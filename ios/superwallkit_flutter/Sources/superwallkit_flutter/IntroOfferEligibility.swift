import Foundation
import StoreKit

/// Lives in its own file: importing StoreKit next to SuperwallKit makes names
/// like `SubscriptionStatus` and `Product` ambiguous in the host.
enum IntroOfferEligibility {
  /// StoreKit 2 eligibility for each product's introductory offer — the same
  /// check the SDK runs before rendering a paywall's trial copy. Products
  /// StoreKit doesn't return, or that have no subscription info, report
  /// `false` so a caller never promises a trial it can't deliver.
  ///
  /// Each `isEligibleForIntroOffer` is its own App Store round trip, so the
  /// products are checked concurrently: a paywall with N plans pays for one
  /// round trip, not N in a row.
  static func check(_ productIds: [String]) async -> [String: Bool] {
    var out: [String: Bool] = [:]
    for id in productIds { out[id] = false }
    if #available(iOS 15.0, *) {
      let products = (try? await StoreKit.Product.products(for: productIds)) ?? []
      let checked = await withTaskGroup(of: (String, Bool).self) { group -> [String: Bool] in
        for product in products {
          guard let subscription = product.subscription else { continue }
          group.addTask { (product.id, await subscription.isEligibleForIntroOffer) }
        }
        var collected: [String: Bool] = [:]
        for await (id, eligible) in group { collected[id] = eligible }
        return collected
      }
      out.merge(checked) { _, new in new }
    }
    return out
  }
}
