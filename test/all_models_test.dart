import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'utils/json_serialization_utils.dart';

void main() {
  createJsonSerializationTests<BulkStorageRegisterItemModel>(
      resourcePath: 'resources/bulkStorageRegisterItem.json',
      fromJson: BulkStorageRegisterItemModel.fromJson);
  createJsonSerializationTests<BulkStorageVesselModel>(
      resourcePath: 'resources/bulkStorageVessel.json',
      fromJson: BulkStorageVesselModel.fromJson);
  createJsonSerializationTests<CartModel>(
      resourcePath: 'resources/carts.json', fromJson: CartModel.fromJson);
  createJsonSerializationTests<CouponModel>(
      resourcePath: 'resources/coupons.json', fromJson: CouponModel.fromJson);
  createJsonSerializationTests<DeliveryAuthorityModel>(
      resourcePath: 'resources/deliveryAuthorities.json',
      fromJson: DeliveryAuthorityModel.fromJson);
  createJsonSerializationTests<DistillationRecordModel>(
      resourcePath: 'resources/distillationRecord.json',
      fromJson: DistillationRecordModel.fromJson);
  createJsonSerializationTests<ExciseReturnModel>(
      resourcePath: 'resources/exciseReturns.json',
      fromJson: ExciseReturnModel.fromJson);
  createJsonSerializationTests<FermentationRecordModel>(
      resourcePath: 'resources/fermentationRecord.json',
      fromJson: FermentationRecordModel.fromJson);
  createJsonSerializationTests<OrderModel>(
      resourcePath: 'resources/orders.json', fromJson: OrderModel.fromJson);
  createJsonSerializationTests<PackagingRunItemModel>(
      resourcePath: 'resources/packagingRunItem.json',
      fromJson: PackagingRunItemModel.fromJson);
  createJsonSerializationTests<PostcodeModel>(
      resourcePath: 'resources/postcodes.json',
      fromJson: PostcodeModel.fromJson);
  createJsonSerializationTests(
      resourcePath: 'resources/productItems.json',
      fromJson: ProductModel.fromJson);
  createJsonSerializationTests<ProductModel>(
      resourcePath: 'resources/products.json', fromJson: ProductModel.fromJson);
  createJsonSerializationTests<RawMaterialsRegisterModel>(
      resourcePath: 'resources/rawMaterialsRegister.json',
      fromJson: RawMaterialsRegisterModel.fromJson);
  createJsonSerializationTests<SaleModel>(
      resourcePath: 'resources/sales.json', fromJson: SaleModel.fromJson);
  createJsonSerializationTests<StockJournalModel>(
      resourcePath: 'resources/stockJournal.json',
      fromJson: StockJournalModel.fromJson);
  createJsonSerializationTests<VolumeTransferredRecordModel>(
      resourcePath: 'resources/volumeTransferredRecords.json',
      fromJson: VolumeTransferredRecordModel.fromJson);
}
