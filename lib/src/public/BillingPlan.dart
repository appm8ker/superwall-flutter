import 'package:superwallkit_flutter/src/generated/superwallhost.g.dart';

/// How an annual App Store subscription is billed.
enum BillingPlan {
  /// One payment for the year.
  upFront,

  /// Twelve monthly payments, with a 12-month commitment.
  monthly;

  PBillingPlan toPigeon() => switch (this) {
        BillingPlan.upFront => PBillingPlan.upFront,
        BillingPlan.monthly => PBillingPlan.monthly,
      };
}
