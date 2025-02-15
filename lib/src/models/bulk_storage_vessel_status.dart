/// Represents the status of a bulk storage vessel.
enum BulkStorageVesselStatus {
  /// Vessel is active and can be used
  active,

  /// Vessel has been decommissioned and cannot be used
  decommissioned,

  /// Vessel is temporarily out of service
  maintenance,
}
