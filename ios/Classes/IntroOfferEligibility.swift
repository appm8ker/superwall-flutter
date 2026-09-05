import Foundation
import StoreKit

/// Lives in its own file: importing StoreKit next to SuperwallKit makes names
/// like `SubscriptionStatus` and `Product` ambiguous in the host.
enum IntroOfferEligibility {
  /// StoreKit 2 eligibility for each product's introductory offer — the same
  /// check the SDK runs before rendering a paywall's trial copy. Products
  /// StoreKit doesn't return, or that have no subscription info, report
  /// `false` so a caller never promises a trial it can't deliver.
  static func check(_ productIds: [String]) async -> [String: Bool] {
    var out: [String: Bool] = [:]
    for id in productIds { out[id] = false }
    if #available(iOS 15.0, *) {
      let products = (try? await StoreKit.Product.products(for: productIds)) ?? []
      for product in products {
        if let subscription = product.subscription {
          out[product.id] = await subscription.isEligibleForIntroOffer
        }
      }
    }
    return out
  }
}
