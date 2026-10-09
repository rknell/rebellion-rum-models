import 'package:rebellion_rum_models/src/models/sale.dart';

/// Integer cents and stable sale/coupon IDs form the checkout wire contract.
/// Reservation state is additive; legacy sales need no migration.
class PosCreditUse {
  final String couponId;
  final int cents;
  PosCreditUse({required this.couponId, required this.cents}) {
    if (!RegExp(r'^[a-f0-9]{24}$').hasMatch(couponId) || cents <= 0) {
      throw ArgumentError('Invalid credit allocation');
    }
  }
  factory PosCreditUse.fromJson(Map<String, dynamic> json) => PosCreditUse(
      couponId: json['couponId'] as String, cents: json['cents'] as int);
  Map<String, dynamic> toJson() => {'couponId': couponId, 'cents': cents};
}

enum PosCheckoutState {
  reserving,
  reserved,
  committing,
  complete,
  cancelling,
  cancelled
}

class PosCheckoutRequest {
  final SaleModel sale;
  final List<PosCreditUse> credits;
  PosCheckoutRequest({required this.sale, required this.credits}) {
    if (credits.length > 20 ||
        credits.map((c) => c.couponId).toSet().length != credits.length) {
      throw ArgumentError('Use at most 20 distinct credit codes');
    }
    if (credits.fold<int>(0, (sum, c) => sum + c.cents) >
        sale.salesRevenueCents) {
      throw ArgumentError('Credit cannot exceed merchandise value');
    }
    sale.validateGiftCardSale();
  }
  factory PosCheckoutRequest.fromJson(Map<String, dynamic> json) =>
      PosCheckoutRequest(
        sale:
            SaleModel.fromJson(Map<String, dynamic>.from(json['sale'] as Map)),
        credits: (json['credits'] as List)
            .map((c) =>
                PosCreditUse.fromJson(Map<String, dynamic>.from(c as Map)))
            .toList(),
      );
  Map<String, dynamic> toJson() => {
        'sale': sale.toJson(),
        'credits': credits.map((c) => c.toJson()).toList()
      };
}

class PosCheckoutSnapshot {
  final String id;
  final PosCheckoutState state;
  final Map<String, dynamic> sale;
  final String? pendingSession;
  PosCheckoutSnapshot(
      {required this.id,
      required this.state,
      required this.sale,
      this.pendingSession});
  factory PosCheckoutSnapshot.fromJson(Map<String, dynamic> json) =>
      PosCheckoutSnapshot(
        id: json['id'] as String,
        state: PosCheckoutState.values.byName(json['state'] as String),
        sale: Map<String, dynamic>.from(json['sale'] as Map),
        pendingSession: json['pendingSession'] as String?,
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'state': state.name,
        'sale': sale,
        'pendingSession': pendingSession
      };
}
