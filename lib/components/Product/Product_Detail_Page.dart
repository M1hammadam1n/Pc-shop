import 'package:flutter/material.dart';
import 'package:pc_shop/components/Call_Button.dart';
import 'package:pc_shop/service/product.dart';
import 'package:pc_shop/theme/app_theme.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        'https://ekwknddvmbdzskwytrdm.supabase.co/storage/v1/object/public/images/${product.imagePath}';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        iconTheme: const IconThemeData(
          color: AppTheme.purpleAccent,
        ),
        title: Text(
          product.title,
          style: const TextStyle(color: AppTheme.white),
        ),
        elevation: 0,
      ),
      backgroundColor: AppTheme.black70,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.purpleAccent.withOpacity(0.5),
                      offset: const Offset(0, 4),
                      blurRadius: 12,
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  imageUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 250,
                    color: AppTheme.gray,
                    child: const Icon(
                      Icons.broken_image,
                      size: 60,
                      color: AppTheme.White30,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                product.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${product.price} сум',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.purpleAccent,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                product.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppTheme.white70,
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: CallButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
