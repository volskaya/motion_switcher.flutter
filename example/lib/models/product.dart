import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const Product._();

  const factory Product({
    required String name,
    required String imageAsset,
    required double price,
    double? discount,
    String? badge,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  bool get hasDiscount => discount != null && discount! < price;

  String getPriceStr() => "\$${price.toStringAsFixed(2)}";
  String? getDiscountStr() => hasDiscount ? "\$${discount!.toStringAsFixed(2)}" : null;
}
