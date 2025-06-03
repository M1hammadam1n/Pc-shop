import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_card_event.dart';
import 'product_card_state.dart';

class ProductCardBloc extends Bloc<ProductCardEvent, ProductCardState> {
  ProductCardBloc()
      : super(ProductCardState(isFavorite: false, isLoading: false)) {
    on<LoadProductImage>((event, emit) {
      emit(state.copyWith(isLoading: true));
      // эмуляция загрузки
      Future.delayed(const Duration(milliseconds: 500), () {
        emit(state.copyWith(isLoading: false));
      });
    });

    on<ToggleFavoriteStatus>((event, emit) {
      emit(state.copyWith(isFavorite: !state.isFavorite));
    });
  }
}
