import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pc_shop/bloc/Favorite/FavoriteEvent.dart';
import 'package:pc_shop/bloc/Favorite/FavoriteState.dart';
import 'package:pc_shop/service/product.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(const FavoriteState()) {
    on<AddFavorite>((event, emit) {
      final updated = List<Product>.from(state.favorites)..add(event.product);
      emit(FavoriteState(favorites: updated));
    });

    on<RemoveFavorite>((event, emit) {
      final updated = List<Product>.from(state.favorites)
        ..removeWhere((p) => p.id == event.product.id);
      emit(FavoriteState(favorites: updated));
    });
  }
}
