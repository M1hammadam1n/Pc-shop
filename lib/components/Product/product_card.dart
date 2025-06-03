import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pc_shop/bloc/Favorite/FavoriteBloc.dart';
import 'package:pc_shop/bloc/Favorite/FavoriteEvent.dart';
import 'package:pc_shop/bloc/Favorite/FavoriteState.dart';
import 'package:pc_shop/components/Product/Product_Detail_Page.dart';
import 'package:pc_shop/service/product.dart';
import 'package:pc_shop/theme/app_theme.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final idFontSize = screenWidth * 0.035;
    final titleFontSize = screenWidth * 0.05;
    final priceFontSize = screenWidth * 0.05;
    final descriptionFontSize = screenWidth * 0.04;
    final imageHeight = screenWidth * 0.55;

    final imageUrl =
        'https://ekwknddvmbdzskwytrdm.supabase.co/storage/v1/object/public/images/${product.imagePath}';

    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, favoriteState) {
        final isFavorite = favoriteState.favorites.any((p) => p.id == product.id);

        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(product: product),
            ),
          ),
          child: Card(
            margin: const EdgeInsets.all(8),
            color: AppTheme.black70,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: AppTheme.black80, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ID: ${product.id}',
                    style: TextStyle(
                      color: AppTheme.white,
                      fontSize: idFontSize,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.02),
                  Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: imageUrl,
                        height: imageHeight,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                            color: AppTheme.white,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error, color: AppTheme.red),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : AppTheme.white,
                          ),
                          onPressed: () {
                            final favoriteBloc = context.read<FavoriteBloc>();
                            if (isFavorite) {
                              favoriteBloc.add(RemoveFavorite(product));
                            } else {
                              favoriteBloc.add(AddFavorite(product));
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenWidth * 0.02),
                  Text(
                    product.title,
                    style: TextStyle(
                      color: AppTheme.white,
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    product.price,
                    style: TextStyle(
                      color: AppTheme.white,
                      fontSize: priceFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.01),
                  Text(
                    product.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppTheme.white,
                      fontSize: descriptionFontSize,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
