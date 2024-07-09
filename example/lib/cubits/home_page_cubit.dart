import 'package:app/cubits/home_page_state.dart';
import 'package:app/models/product.dart';
import 'package:app/utils/our_cubit.dart';

class HomePageCubit extends OurCubit<HomePageState> {
  HomePageCubit() : super(const HomePageState());

  void expandProduct(Product? product) {
    state = state.copyWith(expandedProduct: product);
  }

  void collapseProduct() {
    state = state.copyWith(expandedProduct: null);
  }
}
