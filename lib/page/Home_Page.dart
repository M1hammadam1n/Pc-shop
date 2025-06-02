import 'package:flutter/material.dart';
import 'package:pc_shop/auth/service/product.dart';
import 'package:pc_shop/page/Product/product_card.dart';
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
      baseColor: const Color(0xFF121212), // тёмно-серый
      highlightColor: const Color(0xFF1F1F1F), // чуть светлее
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
      backgroundColor: const Color(0xFF000000), // глубокий чёрный
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        elevation: 0,
        title: const Text(
          "Продукты",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                  style: const TextStyle(color: Colors.redAccent),
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
