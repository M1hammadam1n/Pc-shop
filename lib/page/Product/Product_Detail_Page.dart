import 'package:flutter/material.dart';
import 'package:pc_shop/auth/service/product.dart';
import 'package:pc_shop/page/Call_Button.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        'https://ekwknddvmbdzskwytrdm.supabase.co/storage/v1/object/public/images/${product.imagePath}';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212), // тот же цвет, что и в SearchPage
        iconTheme: const IconThemeData(
          color: Colors.purpleAccent, // акцентный цвет для иконок
        ),
        title: Text(
          product.title,
          style: const TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFF121212), // фон страницы темный, как и раньше
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
                      color: Colors.purpleAccent.withOpacity(0.5),
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
                    color: const Color(0xFF2A2A2A), // темный фон для ошибки картинки
                    child: const Icon(
                      Icons.broken_image,
                      size: 60,
                      color: Colors.white30,
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
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${product.price} сум', // добавил валюту для консистентности
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.purpleAccent, // акцентный цвет для цены
                ),
              ),
              const SizedBox(height: 12),
              Text(
                product.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
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
