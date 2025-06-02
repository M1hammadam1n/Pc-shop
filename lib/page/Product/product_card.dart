import 'package:flutter/material.dart';
import 'package:pc_shop/auth/service/product.dart';
import 'package:pc_shop/page/Product/Product_Detail_Page.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailPage(product: product),
        ),
      ),
      child: Card(
        margin: const EdgeInsets.all(8),
        color: const Color(0xFF121212), // немного светлее
        elevation: 4, // тень для выделения
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(
            color: Color(0xFF1E1E1E), // тонкая граница
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID: ${product.id}',
                style: TextStyle(color: Colors.white, fontSize: idFontSize),
              ),
              SizedBox(height: screenWidth * 0.02),
              CachedNetworkImage(
                imageUrl: imageUrl,
                height: imageHeight,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, color: Colors.red),
              ),
              SizedBox(height: screenWidth * 0.02),
              Text(
                product.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                product.price,
                style: TextStyle(
                  color: Colors.white,
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
                  color: Colors.white,
                  fontSize: descriptionFontSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
