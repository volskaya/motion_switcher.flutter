import 'package:app/models/product.dart';
import 'package:app/resources/resources.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_page_state.freezed.dart';

@freezed
class HomePageState with _$HomePageState {
  const HomePageState._();

  const factory HomePageState({
    Product? expandedProduct,
  }) = _HomePageState;

  final products = const [
    Product(name: "Puma", price: 129.00, discount: 99.00, imageAsset: ImageShoeAssets.shoe1, badge: "NEW"),
    Product(name: "Adidas", price: 180.00, imageAsset: ImageShoeAssets.shoe0, badge: 'NEW'),
    Product(name: "Nike", price: 220.00, discount: 199.00, imageAsset: ImageShoeAssets.shoe2),
    Product(
      name: "Converse",
      price: 129.00,
      discount: 99.00,
      imageAsset: ImageShoeAssets.shoe3,
      badge: "VOLSKAYA/MOTION_SWITCHER.FLUTTER",
    ),
  ];
}
