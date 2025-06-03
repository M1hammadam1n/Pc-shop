import 'package:flutter/material.dart';
import 'package:pc_shop/components/Product/product_card.dart';
import 'package:pc_shop/service/product.dart';
import 'package:pc_shop/theme/app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shimmer/shimmer.dart';

final supabase = Supabase.instance.client;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Product>> fetchProducts() async {
    print("⚙️ fetchProducts called");
    final response = await supabase.from('products').select();
    print("✅ Response: $response");
    return (response as List).map((item) => Product.fromJson(item)).toList();
  }

  Widget shimmerCard() {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF121212),
      highlightColor: const Color(0xFF1F1F1F),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        height: 180,
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black,
      appBar: AppBar(
        backgroundColor: AppTheme.black,
        elevation: 0,
        title: const Text(
          "Продукты",
          style: TextStyle(color: AppTheme.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Product>>(
          future: fetchProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Ошибка: ${snapshot.error}',
                  style: const TextStyle(color: AppTheme.redAccent),
                ),
              );
            }

            if (!snapshot.hasData) {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 12),
                itemCount: 5,
                itemBuilder: (context, index) => shimmerCard(),
              );
            }

            final products = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
