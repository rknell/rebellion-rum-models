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

export enum OrderStatus {
  cancelled = "cancelled",
  delivered = "delivered",
  paid = "paid",
  pending = "pending",
  shipped = "shipped",
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

export enum StripeSetupFutureUsage {
  offSession = "off_session",
  onSession = "on_session",
}

export interface AlcocalcDilutionInputModel {
  bottleSize: number | null;
  createdAt: string | null;
  productId: string | null;
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

export interface Award {
  competition: string;
  id: number;
  level: string;
  year: number;
}

export interface BotanicalModel {
  _id: string;
  botanicalName: string;
  createdAt: string | null;
  description: string;
  id: number;
  image: string;
  isActive: boolean | null;
  isFeatured: boolean | null;
  name: string;
  productIds: string[] | null;
  updatedAt: string | null;
}

export interface BulkStorageRegisterItemModel {
  _id: string;
  feintsDestroyed: boolean | null;
  fromChargeId: string | null;
  fromPackagingId: string | null;
  fromVesselId: string | null;
  isStocktake: boolean | null;
  lals: number | null;
  lalsCalculation: AlcocalcLalsCalculation | null;
  notes: string | null;
  productId: string | null;
  toChargeId: string | null;
  toPackagingId: string | null;
  toVesselId: string | null;
  wastage: boolean | null;
}

export interface BulkStorageVesselModel {
  _id: string;
  barcode: string | null;
  capacity: number | null;
  currentLals: number | null;
  name: string | null;
  needsStocktake: boolean | null;
  productId: string | null;
  status: BulkStorageVesselStatus;
}

export interface CartModel {
  _id: string;
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

export interface CocktailRecipeModel {
  _id: string;
  createdAt: string | null;
  description: string;
  featuredProductIds: string[] | null;
  garnish: string | null;
  glass: string;
  image: string | null;
  imageThumbnail: string | null;
  ingredients: string[];
  instructions: string[];
  isActive: boolean | null;
  isFeatured: boolean | null;
  llmDescription: string | null;
  name: string;
  slug: string;
  updatedAt: string | null;
}

export interface CouponModel {
  _id: string;
  amount: number;
  code: string;
  description: string;
  email: string | null;
  phone: string | null;
  redeemed: boolean | null;
  remainingValue: number | null;
}

export interface CustomerModel {
  _id: string;
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
  _id: string;
  deliveryAuthorityNumber: string;
  lals: number;
}

export interface DeliveryMethodModel {
  service_code: string;
  service_name: string;
  total_price: number;
}

export interface DistillationRecordModel {
  _id: string;
  feintsAdded: number | null;
  lalsCharged: number | null;
  notes: NoteModel[] | null;
  startTime: string | null;
  status: DistillationStatus;
  stillUsed: string | null;
  totalLALsCharged: number | null;
  totalLALsYield: number | null;
}

export interface EftposTerminalModel {
  _id: string;
  createdAt: string | null;
  lastUsed: string | null;
  name: string;
  secret: string;
}

export interface ExciseReturnModel {
  _id: string;
  referenceNumber: string | null;
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
  _id: string;
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

export interface NewsletterSignupModel {
  _id: string;
  contactInfo: string;
  isActive: boolean | null;
  signupDate: string | null;
}

export interface NoteModel {
  content: string;
  date: string;
  isSystem: boolean | null;
}

export interface OrderModel {
  _id: string;
  customer: CustomerModel | null;
  customerId: string | null;
  date: string | null;
  items: Record<string, number>;
  metadata: Record<string, any> | null;
  notes: string | null;
  orderNumber: string | null;
  paymentIntentClientSecret: string | null;
  paymentMethod: string | null;
  shippingMethod: string | null;
  shippingReceipt: Record<string, any> | null;
  status: OrderStatus;
  totalQuote: number | null;
}

export interface PackagingRunItemModel {
  _id: string;
  abvReading: number | null;
  completionDate: string | null;
  discrepancyNote: string | null;
  estimatedDilution: AlcocalcDilutionResultModel | null;
  exciseReturn: string | null;
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
  _id: string;
  amount: number;
  reference: string | null;
  type: PaymentType;
}

export interface PostcodeModel {
  _id: string;
  combined: string;
  locality: string;
  postcode: string;
  state: string;
}

export interface ProductEphemeralDetails {
  barcode: string;
  price: number;
  stock: number;
}

export interface ProductEphemeralDetailsResponse {
  items: ProductEphemeralDetails[];
  success: boolean;
  total: number;
}

export interface ProductModel {
  _id: string;
  abv: number | null;
  awards: Award[] | null;
  barcode: string;
  botanicals: number[] | null;
  bottleImage: string | null;
  category: ProductCategory;
  enabled: boolean | null;
  headerAlignment: string | null;
  heroDescription: string | null;
  heroImage: string | null;
  isArchived: boolean | null;
  isAvailableOnline: boolean | null;
  isFeatured: boolean | null;
  matesRatesPrice: number | null;
  name: string | null;
  percentAustralian: number | null;
  price: number;
  productType: string | null;
  recipe: ProductRecipe | null;
  recipeSlugs: string[] | null;
  shortcut: string | null;
  slug: string | null;
  stock: number | null;
  story1: string | null;
  story1Image: string | null;
  story2: string | null;
  story2Image: string | null;
  volume: number | null;
  weight: number | null;
}

export interface ProductRecipe {
  sugars: SugarInputModel[] | null;
  targetAbv: number;
}

export interface RawMaterialTypeModel {
  _id: string;
  name: string;
  specificGravity: number;
}

export interface RawMaterialsRegisterModel {
  _id: string;
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
  _id: string;
  coupons: any[];
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

export interface StarShipItAddress {
  country: string;
  delivery_instructions: string | null;
  name: string;
  phone: string;
  post_code: string;
  state: string;
  street: string;
  suburb: string;
}

export interface StarShipItAddressResponse {
  country: string;
  delivery_instructions: string | null;
  name: string;
  phone: string;
  post_code: string;
  state: string;
  street: string;
  suburb: string;
}

export interface StarShipItCreateOrderRequest {
  order: StarShipItOrder;
}

export interface StarShipItCreateOrderResponse {
  order: StarShipItOrderResponse;
  success: boolean | null;
}

export interface StarShipItItem {
  country_of_origin: string | null;
  description: string | null;
  item_id: number | null;
  quantity: number | null;
  quantity_to_ship: number | null;
  sku: string | null;
  tariff_code: string | null;
  value: number | null;
  weight: number | null;
}

export interface StarShipItItemResponse {
  description: string;
  item_id: number;
  quantity: number;
  quantity_to_ship: number;
  sku: string;
  value: number;
  weight: number;
}

export interface StarShipItOrder {
  carrier: string | null;
  carrier_name: string | null;
  currency: string | null;
  destination: StarShipItAddress;
  items: StarShipItItem[] | null;
  order_date: string | null;
  order_number: string;
  packages: StarShipItPackage[] | null;
  reference: string | null;
  return_order: boolean | null;
  sender_details: StarShipItAddress | null;
  shipping_description: string | null;
  shipping_method: string | null;
  signature_required: boolean | null;
}

export interface StarShipItOrderResponse {
  carrier: any;
  carrier_name: string | null;
  carrier_service_code: string | null;
  dangerous_goods: boolean | null;
  declared_value: number | null;
  destination: StarShipItAddressResponse;
  items: StarShipItItemResponse[] | null;
  order_date: string;
  order_id: number;
  order_number: string;
  packages: StarShipItPackageResponse[] | null;
  reference: string | null;
  shipping_method: string | null;
  signature_required: boolean | null;
}

export interface StarShipItPackage {
  height: number | null;
  length: number | null;
  weight: number | null;
  width: number | null;
}

export interface StarShipItPackageResponse {
  height: number;
  length: number;
  package_id: number;
  weight: number;
  width: number;
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
  _id: string;
  capacityLiters: number;
  commissionedDate: string;
  decommissionedDate: string | null;
  description: string | null;
  isActive: boolean | null;
  name: string;
}

export interface StockJournalModel {
  _id: string;
  barcode: string;
  from: string;
  qty: number;
  to: string;
  type: string;
}

export interface StockLocationModel {
  _id: string;
  barcode: string;
  isAvailableOnline: boolean;
  isBondStore: boolean;
  isRetail: boolean;
  isWarehouse: boolean;
  name: string;
  stockLevels: Record<string, string[]> | null;
}

export interface StocktakeModel {
  _id: string;
  currentStock: number;
  materialType: string;
  newCount: number;
  timestamp: string | null;
}

export interface StripeAddress {
  city: string | null;
  country: string | null;
  line1: string | null;
  line2: string | null;
  postal_code: string | null;
  state: string | null;
}

export interface StripeConfirmPaymentIntentRequest {
  error_on_requires_action: boolean | null;
  mandate: string | null;
  payment_method: string | null;
  receipt_email: string | null;
  return_url: string | null;
  setup_future_usage: StripeSetupFutureUsage;
  shipping: StripeShippingDetails | null;
  use_stripe_sdk: boolean | null;
}

export interface StripeConfirmPaymentIntentResponse {
  amount: number;
  amount_capturable: number | null;
  amount_details: Record<string, number> | null;
  amount_received: number | null;
  application: string | null;
  application_fee_amount: number | null;
  automatic_payment_methods: Record<string, string[]> | null;
  canceled_at: number | null;
  cancellation_reason: string | null;
  capture_method: string;
  client_secret: string;
  confirmation_method: string;
  created: number;
  currency: string;
  customer: string | null;
  description: string | null;
  id: string;
  last_payment_error: Record<string, any> | null;
  latest_charge: string | null;
  livemode: boolean;
  metadata: Record<string, any> | null;
  next_action: Record<string, any> | null;
  object: string;
  on_behalf_of: string | null;
  payment_method: string | null;
  payment_method_options: Record<string, string[]> | null;
  payment_method_types: string[] | null;
  processing: Record<string, any> | null;
  receipt_email: string | null;
  review: string | null;
  setup_future_usage: string | null;
  shipping: Record<string, any> | null;
  source: string | null;
  statement_descriptor: string | null;
  statement_descriptor_suffix: string | null;
  status: string;
  transfer_data: Record<string, any> | null;
  transfer_group: string | null;
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

export interface StripeShippingDetails {
  address: StripeAddress | null;
  carrier: string | null;
  name: string | null;
  phone: string | null;
  tracking_number: string | null;
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
  _id: string;
  chargeId: string;
  lals: number;
  volume: number;
  washId: string;
}

