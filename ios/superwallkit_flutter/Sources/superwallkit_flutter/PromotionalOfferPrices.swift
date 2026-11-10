import Foundation
import StoreKit

/// Lives in its own file, like `IntroOfferEligibility`: importing StoreKit next
/// to SuperwallKit makes names ambiguous in the host.
enum PromotionalOfferPrices {
  /// The price of each promotional offer of a product, by offer id. The App
  /// Store lists them to every user, eligible or not. Empty when StoreKit
  /// doesn't return the product or it has no offers.
  static func fetch(_ productId: String) async -> [String: Double] {
    let products = (try? await StoreKit.Product.products(for: [productId])) ?? []
    let offers = products.first { $0.id == productId }?.subscription?.promotionalOffers ?? []
    var out: [String: Double] = [:]
    for offer in offers {
      guard let id = offer.id else { continue }
      out[id] = NSDecimalNumber(decimal: offer.price).doubleValue
    }
    return out
  }
}
