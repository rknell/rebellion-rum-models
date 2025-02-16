/// Represents different types of movements in the bulk storage system.
enum BulkStorageMovementType {
  /// Movement from still to vessel
  fromStill,

  /// Movement between vessels
  vesselTransfer,

  /// Movement to still for re-distillation
  toStill,

  /// Movement to packaging
  toPackaging,

  /// Underbond movement
  underbond,

  /// Feints destroyed
  feintsDestroyed,

  /// Manufacture operations (mixing, dilution)
  manufacture,

  /// Stocktake adjustment
  stocktake,

  /// Wastage
  wastage,

  /// The default return type if the others ca
  unknown,
}
