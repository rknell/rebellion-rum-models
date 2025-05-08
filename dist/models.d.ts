// Generated TypeScript definitions from .g.dart files
// DO NOT EDIT. This file is auto-generated.

export enum BulkStorageVesselStatus {
  active = "active",
  decommissioned = "decommissioned",
  maintenance = "maintenance",
}

export enum CustomerPreferences {
  beer = "beer",
  blueGin = "blueGin",
  citrusGin = "citrusGin",
  coconutRum = "coconutRum",
  darkRum = "darkRum",
  gin = "gin",
  other = "other",
  pinkGin = "pinkGin",
  rum = "rum",
  spicedRum = "spicedRum",
  traditionalGin = "traditionalGin",
  vodka = "vodka",
  whiteRum = "whiteRum",
}

export enum DistillationStatus {
  archived = "archived",
  completed = "completed",
  inProgress = "inProgress",
}

export enum FermentationType {
  caneSugar = "caneSugar",
  grain = "grain",
  grape = "grape",
  mixed = "mixed",
  molasses = "molasses",
  other = "other",
}

export enum PackagingRunStatus {
  awaitingExcise = "awaitingExcise",
  complete = "complete",
  excised = "excised",
  inProgress = "inProgress",
}

export enum PaymentType {
  bank = "bank",
  cash = "cash",
  coupon = "coupon",
  eftpos = "eftpos",
  online = "online",
  unknown = "unknown",
}

export enum ProductCategory {
  gin = "gin",
  merch = "merch",
  other = "other",
  rum = "rum",
  softdrink = "softdrink",
  vodka = "vodka",
}

export enum SaleStatus {
  paid = "paid",
  unpaid = "unpaid",
}

export interface AlcocalcDilutionInputModel {
  bottleSize: number | null;
  createdAt: string | null;
  productId: any;
  startingABV: number;
  startingTemperature: number;
  startingWeight: number;
  sugars: SugarInputModel[] | null;
  targetABV: number;
}

export interface AlcocalcDilutionResultModel {
  acceptableABVHigh: number;
  acceptableABVLow: number;
  additionalWaterLitres: number;
  calculatedABV: number;
  correctedStartingABV: number;
  date: string;
  expectedBottles: number;
  lals: number;
  startingWeight: number;
  sugarResults: SugarResultModel[];
  targetFinalWeight: number;
  targetVolume: number;
  targetWeightAfterWater: number;
}

export interface AlcocalcLalsCalculation {
  abv: number;
  temperature: number;
  weight: number;
}

export interface AlcoholAdditionResultModel {
  additionABV: number;
  additionDensity: number;
  additionVolume: number;
  correctedAdditionABV: number;
  correctedCurrentABV: number;
  createdAt: string | null;
  currentABV: number;
  currentAlcoholVolume: number;
  currentDensity: number;
  currentVolume: number;
  currentWeight: number;
  finalVolume: number;
  finalWeight: number;
  lals: number;
  requiredAlcoholWeight: number;
  targetABV: number;
  targetDensity: number;
  temperature: number;
}

export interface BulkStorageRegisterItemModel {
  _id: any;
  feintsDestroyed: boolean | null;
  fromChargeId: any;
  fromPackagingId: any;
  fromVesselId: any;
  isStocktake: boolean | null;
  lals: number | null;
  lalsCalculation: AlcocalcLalsCalculation | null;
  notes: string | null;
  productId: any;
  toChargeId: any;
  toPackagingId: any;
  toVesselId: any;
  wastage: boolean | null;
}

export interface BulkStorageVesselModel {
  _id: any;
  barcode: string | null;
  capacity: number | null;
  currentLals: number | null;
  name: string | null;
  needsStocktake: boolean | null;
  productId: any;
  status: BulkStorageVesselStatus;
}

export interface CartModel {
  _id: any;
  cartId: string;
  deliveryMethod: DeliveryMethodModel | null;
  products: CartProductModel[];
  userInfo: UserInfoModel;
}

export interface CartProductModel {
  barcode: string;
  href: string;
  id: string;
  imageAlt: string;
  imageSrc: string;
  name: string;
  price: number;
  quantity: number;
  stock: number;
  volume: number;
}

export interface ConfirmPaymentRequest {
  payment_intent_id: string;
  payment_method_id: string | null;
}

export interface ConfirmPaymentResponse {
  payment_intent: Record<string, number> | null;
  status: string | null;
  success: boolean;
}

export interface CouponModel {
  _id: any;
  amount: number;
  code: string;
  description: string;
  email: string | null;
  phone: string | null;
  redeemed: boolean | null;
  remainingValue: number | null;
}

export interface CustomerModel {
  _id: any;
  addressLine1: string;
  addressLine2: string | null;
  city: string;
  companyName: string | null;
  country: string | null;
  email: string;
  firstName: string;
  isWholesale: boolean | null;
  lastName: string;
  phone: string;
  postcode: string;
  preferences: any[] | null;
  state: string;
}

export interface DeliveryAuthorityModel {
  _id: any;
  deliveryAuthorityNumber: string;
  lals: number;
}

export interface DeliveryMethodModel {
  service_code: string;
  service_name: string;
  total_price: number;
}

export interface DistillationRecordModel {
  _id: any;
  feintsAdded: number | null;
  ginStillStocktake: GinStillStocktakeModel;
  lalsCharged: number | null;
  notes: NoteModel[] | null;
  startTime: string | null;
  status: DistillationStatus;
  stillUsed: string | null;
  totalLALsCharged: number | null;
  totalLALsYield: number | null;
}

export interface EftposTerminalModel {
  _id: any;
  createdAt: string | null;
  lastUsed: string | null;
  name: string;
  secret: string;
}

export interface ExciseReturnModel {
  _id: any;
  remissionApplied: boolean;
  totalLals: number;
}

export interface FermentationProgressModel {
  notes: string;
  ph: number | null;
  sg: number;
  temp: number | null;
  timestamp: string;
}

export interface FermentationRecordModel {
  _id: any;
  batchNumber: number;
  completed: boolean | null;
  completionDate: string | null;
  fermentationProgress: FermentationProgressModel[] | null;
  notes: string | null;
  recipe: string | null;
  sgEnd: number;
  sgStart: number;
  type: FermentationType;
  vesselBarcode: string;
  washVolume: number;
}

export interface GinStillStocktakeModel {
  abv: number;
  height: number;
  temperature: number | null;
}

export interface NoteModel {
  content: string;
  date: string;
  isSystem: boolean | null;
}

export interface OrderModel {
  _id: any;
  customer: CustomerModel;
  date: string;
  items: Record<string, number>;
  orderNumber: string;
  paymentMethod: string | null;
  paymentReceipt: Record<string, any> | null;
  shippingMethod: string | null;
  shippingReceipt: Record<string, any> | null;
  totalQuote: number;
}

export interface PackagingRunItemModel {
  _id: any;
  abvReading: number | null;
  completionDate: string | null;
  discrepancyNote: string | null;
  estimatedDilution: AlcocalcDilutionResultModel | null;
  exciseReturn: any;
  isConfirmedSugars: boolean | null;
  packagingLosses: number | null;
  productBarcode: string | null;
  productionDilution: AlcocalcDilutionResultModel | null;
  remaining: number | null;
  status: PackagingRunStatus;
  strength: number | null;
  targetBottles: number | null;
  timestamp: string | null;
  unitSize: number | null;
  unitsPackaged: number | null;
  volumeAvailable: number | null;
  volumeRemaining: number | null;
}

export interface PaymentIntentRequest {
  address: StartShipItRateDestinationAddressModel;
  items: Record<string, number>;
  shipping_method: string;
}

export interface PaymentModel {
  _id: any;
  amount: number;
  reference: string | null;
  type: PaymentType;
}

export interface PostcodeModel {
  _id: any;
  combined: string;
  locality: string;
  postcode: string;
  state: string;
}

export interface ProductModel {
  _id: any;
  abv: number | null;
  barcode: string;
  category: ProductCategory;
  enabled: boolean | null;
  images: string[] | null;
  isArchived: boolean | null;
  isAvailableOnline: boolean | null;
  longDescription: string | null;
  matesRatesPrice: number | null;
  name: string | null;
  percentAustralian: number | null;
  price: number;
  productType: string | null;
  recipe: ProductRecipe | null;
  shortDescription: string | null;
  shortcut: string | null;
  stock: number | null;
  volume: number | null;
  weight: number | null;
}

export interface ProductRecipe {
  sugars: SugarInputModel[] | null;
  targetAbv: number;
}

export interface RawMaterialTypeModel {
  _id: any;
  name: string;
  specificGravity: number;
}

export interface RawMaterialsRegisterModel {
  _id: any;
  batchNumber: string | null;
  fermentationRecordId: any;
  invoiceNumber: string | null;
  materialType: string;
  qtyIn: number;
  qtyOut: number;
  timestamp: string | null;
}

export interface SaleItemModel {
  description: string;
  itemId: string;
  price: number;
  qty: number;
}

export interface SaleModel {
  _id: any;
  coupons: any;
  customerId: string | null;
  discountTotal: number | null;
  dueDate: string | null;
  eftposSessionId: string | null;
  isMatesRates: boolean | null;
  items: SaleItemModel[] | null;
  payments: PaymentModel[] | null;
  status: SaleStatus;
  timestamp: string | null;
  total: number | null;
}

export interface ShippingQuoteRequestModel {
  address: StartShipItRateDestinationAddressModel;
  items: Record<string, number>;
}

export interface StartShipItErrorModel {
  details: string;
  message: string;
}

export interface StartShipItGetRatesRequestModel {
  currency: string | null;
  destination: StartShipItRateDestinationAddressModel;
  packages: StartShipItRatePackageModel[];
  sender: StartShipItRateSenderAddressModel | null;
}

export interface StartShipItGetRatesResponseModel {
  rates: StartShipItRateModel[];
  success: boolean;
}

export interface StartShipItRateDestinationAddressModel {
  country_code: string | null;
  post_code: string;
  state: string;
  street: string;
  suburb: string;
}

export interface StartShipItRateModel {
  service_code: string;
  service_name: string;
  total_price: number;
}

export interface StartShipItRatePackageModel {
  height: number | null;
  length: number | null;
  weight: number;
  width: number | null;
}

export interface StartShipItRateSenderAddressModel {
  country_code: string;
  post_code: string;
  state: string;
  street: string;
  suburb: string;
}

export interface StillModel {
  _id: any;
  capacityLiters: number;
  commissionedDate: string;
  decommissionedDate: string | null;
  description: string | null;
  isActive: boolean | null;
  name: string;
}

export interface StockJournalModel {
  _id: any;
  barcode: string;
  from: string;
  qty: number;
  to: string;
  type: string;
}

export interface StockLocationModel {
  _id: any;
  barcode: string;
  isAvailableOnline: boolean;
  isBondStore: boolean;
  isRetail: boolean;
  isWarehouse: boolean;
  name: string;
  stockLevels: Record<string, string[]> | null;
}

export interface StocktakeModel {
  _id: any;
  currentStock: number;
  materialType: string;
  newCount: number;
  timestamp: string | null;
}

export interface StripePaymentIntentModel {
  amount: number;
  amount_capturable: number;
  amount_received: number;
  capture_method: string;
  client_secret: string;
  confirmation_method: string;
  created: number;
  currency: string;
  description: string | null;
  id: string;
  livemode: boolean;
  metadata: Record<string, any> | null;
  payment_method_options: Record<string, string[]> | null;
  payment_method_types: string[];
  status: string;
}

export interface StripePublicKeyResponse {
  publishable_key: string;
  success: boolean;
}

export interface SugarInputModel {
  name: string;
  percentage: number;
  specificGravity: number;
}

export interface SugarResultModel {
  name: string;
  runningWeight: number;
  weight: number;
}

export interface UserInfoModel {
  address: string;
  apartment: string;
  country: string;
  email: string;
  firstName: string;
  lastName: string;
  phone: string;
  postcode: string;
  state: string;
  suburb: string;
}

export interface VolumeTransferredRecordModel {
  _id: any;
  chargeId: any;
  lals: number;
  volume: number;
  washId: any;
}

