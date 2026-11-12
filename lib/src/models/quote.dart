import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/rebellion_rum_models.dart';

/// Immutable commercial snapshot managed by the website's quote API.
class Quote {
  Quote(
      {required this.id,
      required this.saleId,
      required this.createdAt,
      required this.validUntil,
      required this.deleteAt,
      required this.customer,
      required this.email,
      required this.address,
      required this.snapshot,
      this.status = 'open',
      this.owner,
      this.quoteNumber,
      this.invoiceNumber,
      this.revision = 0,
      this.accountId,
      this.wholesaleInvoiceId});

  final ObjectId id;
  final ObjectId saleId;
  final DateTime createdAt, validUntil, deleteAt;
  final String customer, email, address;
  final SaleModel snapshot;
  final String status;
  final String? owner, invoiceNumber;

  final String? quoteNumber;
  final int revision;
  final String? accountId, wholesaleInvoiceId;
  String get legacyNumber => 'Q-${id.oid.toUpperCase()}';
  String get number => quoteNumber ?? legacyNumber;
  double get subtotal =>
      snapshot.items.fold(0.0, (sum, item) => sum + item.price * item.qty);
  double get total => subtotal - (snapshot.discountTotal ?? 0);
  bool isExpired(DateTime now) => !now.isBefore(validUntil);
  String statusAt(DateTime now) => status == 'complete'
      ? 'Complete'
      : status == 'invoicing'
          ? 'Invoice draft'
          : status == 'inProgress'
              ? 'In progress'
              : isExpired(now)
                  ? 'Review prices'
                  : 'Open';

  static DateTime retentionDate(DateTime created) {
    final utc = created.toUtc();
    final lastDay = DateTime.utc(utc.year, utc.month + 7, 0).day;
    return DateTime.utc(
        utc.year,
        utc.month + 6,
        utc.day > lastDay ? lastDay : utc.day,
        utc.hour,
        utc.minute,
        utc.second,
        utc.millisecond,
        utc.microsecond);
  }

  factory Quote.create(SaleModel sale,
      {required String customer,
      String email = '',
      String address = '',
      DateTime? now}) {
    final created = (now ?? DateTime.now()).toUtc();
    if (customer.trim().isEmpty ||
        customer.length > 200 ||
        email.length > 254 ||
        address.length > 1000) {
      throw StateError('Enter a customer name and valid customer details.');
    }
    if (sale.items.isEmpty ||
        sale.items.any((i) => i.qty <= 0 || !i.price.isFinite || i.price < 0) ||
        sale.payments.isNotEmpty ||
        sale.coupons.isNotEmpty ||
        sale.eftposSessionId != null) {
      throw StateError(
          'Quotes need positive quantities and no payments, vouchers, or active EFTPOS session.');
    }
    final snapshot = SaleModel.fromJson(sale.toJson());
    final quote = Quote(
        id: ObjectId(),
        saleId: ObjectId(),
        createdAt: created,
        validUntil: created.add(const Duration(days: 42)),
        deleteAt: retentionDate(created),
        customer: customer.trim(),
        email: email.trim(),
        address: address.trim(),
        snapshot: snapshot);
    if (!quote.total.isFinite || quote.total < 0) {
      throw StateError('The quote total must be zero or greater.');
    }
    return quote;
  }

  SaleModel toSale() => SaleModel(
        id: saleId,
        items: snapshot.items
            .map((i) => SaleItemModel.fromJson(i.toJson()))
            .toList(),
        payments: [],
        coupons: <CouponModel>[],
        timestamp: DateTime.now(),
        customerId: snapshot.customerId,
        isMatesRates: snapshot.isMatesRates,
        discountTotal: snapshot.discountTotal,
        metadata: {'sourceQuoteId': id.oid, 'sourceQuoteRevision': revision},
      );

  Map<String, dynamic> toJson() => {
        '_id': id.oid,
        'schemaVersion': 2,
        'revision': revision,
        if (accountId != null) 'accountId': accountId,
        if (wholesaleInvoiceId != null)
          'wholesaleInvoiceId': wholesaleInvoiceId,
        'saleId': saleId.oid,
        'createdAt': createdAt.toIso8601String(),
        'validUntil': validUntil.toIso8601String(),
        'deleteAt': deleteAt.toIso8601String(),
        'customer': customer,
        'email': email,
        'address': address,
        'snapshot': snapshot.toJson(),
        'status': status,
        if (quoteNumber != null) 'quoteNumber': quoteNumber,
        if (owner != null) 'owner': owner,
        if (invoiceNumber != null) 'invoiceNumber': invoiceNumber,
      };

  Map<String, dynamic> toDatabase() => {
        ...toJson(),
        '_id': id,
        'saleId': saleId,
        'createdAt': createdAt,
        'validUntil': validUntil,
        'deleteAt': deleteAt
      };

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        id: const ObjectIdConverter().fromJson(json['_id']),
        saleId: const ObjectIdConverter().fromJson(json['saleId']),
        createdAt: jsonToDateTime(json['createdAt']),
        validUntil: jsonToDateTime(json['validUntil']),
        deleteAt: jsonToDateTime(json['deleteAt']),
        customer: json['customer'] as String,
        email: json['email'] as String? ?? '',
        address: json['address'] as String? ?? '',
        snapshot: SaleModel.fromJson(
            Map<String, dynamic>.from(json['snapshot'] as Map)),
        status: json['status'] as String? ?? 'open',
        owner: json['owner'] as String?,
        quoteNumber: json['quoteNumber'] as String?,
        invoiceNumber: json['invoiceNumber'] as String?,
        revision: _revision(json),
        accountId: _reference(json, 'accountId'),
        wholesaleInvoiceId: _reference(json, 'wholesaleInvoiceId'),
      );

  // Legacy records have no revision or account link. Null means absent; other
  // malformed persisted values are rejected before an edit can overwrite them.
  static int _revision(Map<String, dynamic> json) {
    final value = json['revision'];
    if (value == null) return 0;
    if (value is! int || value < 0) {
      throw FormatException('Quote ${json['_id']}: invalid revision');
    }
    return value;
  }

  static String? _reference(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value == null) return null;
    if (value is! String || value.trim().isEmpty || value.length > 200) {
      throw FormatException('Quote ${json['_id']}: invalid $key');
    }
    return value;
  }
}
