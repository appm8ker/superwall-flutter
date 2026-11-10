import 'package:superwallkit_flutter/src/generated/superwallhost.g.dart';

/// An App Store promotional offer, with the JWS your server signed for this
/// purchase using the account's In-App Purchase key.
class PromotionalOffer {
  const PromotionalOffer({required this.offerId, required this.compactJws});

  /// The offer's identifier in App Store Connect.
  final String offerId;

  /// The signed request, in compact form. The App Store accepts each one once.
  final String compactJws;

  PPromotionalOffer toPigeon() =>
      PPromotionalOffer(offerId: offerId, compactJws: compactJws);
}
