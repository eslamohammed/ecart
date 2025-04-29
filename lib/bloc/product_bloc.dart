import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/api_service.dart';
import '../services/db_service.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
  }

  Future<void> _onFetchProducts(FetchProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await ApiService.fetchProducts();
      emit(ProductLoaded(products));

      await DBService.insertProducts(products); // Cache for offline
    } catch (_) {
      try {
        final localProducts = await DBService.getProducts();
        if (localProducts.isNotEmpty) {
          emit(ProductLoaded(localProducts));
        } else {
          emit(ProductError('No internet and no cached data.'));
        }
      } catch (e) {
        emit(ProductError('Failed to load products.'));
      }
    }
  }
}
