import 'package:pc_shop/service/product.dart';

abstract class FavoriteEvent {}

class AddFavorite extends FavoriteEvent {
  final Product product;
  AddFavorite(this.product);
}

class RemoveFavorite extends FavoriteEvent {
  final Product product;
  RemoveFavorite(this.product);
}
