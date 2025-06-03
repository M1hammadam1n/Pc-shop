import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pc_shop/bloc/Favorite/FavoriteBloc.dart';
import 'package:pc_shop/bloc/Favorite/FavoriteState.dart';
import 'package:pc_shop/components/Product/Product_Card.dart';
import 'package:pc_shop/theme/app_theme.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Избранное',style: TextStyle(color: AppTheme.white),),
        backgroundColor: AppTheme.black,
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state.favorites.isEmpty) {
            return const Center(child: Text('Нет избранных товаров.',style: TextStyle(color: AppTheme.white),));
          }

          return ListView.builder(
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              final product = state.favorites[index];

              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: ProductCard(product: product),
              );
            },
          );
        },
      ),
      backgroundColor: AppTheme.black,
    );
  }
}
