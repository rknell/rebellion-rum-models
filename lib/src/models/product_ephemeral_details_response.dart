import 'package:json_annotation/json_annotation.dart';
import 'product.dart';

part 'product_ephemeral_details_response.g.dart';

/// Response model containing ephemeral product details such as price and stock
///
/// This model is used to fetch lightweight product information for display purposes
/// without requiring the full product object. This is especially useful for
/// scenarios where only the current price and stock levels are needed.
@JsonSerializable()
class ProductEphemeralDetails {
  /// The product's barcode (unique identifier)
  final String barcode;

  /// The current price of the product
  final double price;

  /// The current stock level of the product
  final int stock;

  /// Creates a new ProductEphemeralDetailsResponse.
  ///
  /// @param barcode The product's barcode
  /// @param price The current price of the product
  /// @param stock The current stock level
  ProductEphemeralDetails({
    required this.barcode,
    required this.price,
    required this.stock,
  });

  /// Creates a ProductEphemeralDetails from a ProductModel
  ///
  /// This factory constructor provides a convenient way to extract only
  /// the ephemeral details (barcode, price, stock) from a full ProductModel.
  factory ProductEphemeralDetails.fromProductModel(ProductModel product) {
    return ProductEphemeralDetails(
      barcode: product.barcode,
      price: product.price,
      stock: product.stock,
    );
  }

  /// Creates a ProductEphemeralDetailsResponse from JSON data
  factory ProductEphemeralDetails.fromJson(Map<String, dynamic> json) =>
      _$ProductEphemeralDetailsFromJson(json);

  /// Converts this ProductEphemeralDetailsResponse to JSON
  Map<String, dynamic> toJson() => _$ProductEphemeralDetailsToJson(this);
}

/// Wrapper response containing a list of ProductEphemeralDetailsResponse objects
///
/// This wrapper ensures we never return bare lists from API endpoints,
/// following the project's API design guidelines.
@JsonSerializable()
class ProductEphemeralDetailsResponse {
  /// Whether the request was successful
  final bool success;

  /// The list of product ephemeral details
  final List<ProductEphemeralDetails> items;

  /// The total number of items in the response
  final int total;

  /// Creates a new ProductEphemeralDetailsListResponse.
  ///
  /// @param success Whether the request was successful
  /// @param items The list of product ephemeral details
  /// @param total The total number of items
  ProductEphemeralDetailsResponse({
    required this.success,
    required this.items,
    required this.total,
  });

  /// Creates a ProductEphemeralDetailsListResponse from JSON data
  factory ProductEphemeralDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductEphemeralDetailsResponseFromJson(json);

  /// Converts this ProductEphemeralDetailsListResponse to JSON
  Map<String, dynamic> toJson() =>
      _$ProductEphemeralDetailsResponseToJson(this);
}
