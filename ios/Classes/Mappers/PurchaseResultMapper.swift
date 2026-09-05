import Foundation
import SuperwallKit

extension PurchaseResult {
  func pigeonify() -> PPurchaseResult {
    switch self {
    case .purchased:
      return PPurchasePurchased()
    case .pending:
      return PPurchasePending()
    case .cancelled:
      return PPurchaseCancelled()
    case .failed(let error):
      return PPurchaseFailed(error: error.localizedDescription)
    }
  }
}
