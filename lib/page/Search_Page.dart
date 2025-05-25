import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pc_shop/auth/service/product.dart';
import 'product_detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Product> searchResults = [];
  String query = '';
  bool isLoading = false;

  final supabase = Supabase.instance.client;

  Future<void> searchProducts(String text) async {
    setState(() {
      isLoading = true;
    });

    final response = await supabase
        .from('products')
        .select()
        .ilike('title', '%$text%'); // нечёткий поиск

    final data = response as List<dynamic>;

    setState(() {
      searchResults = data.map((item) {
        return Product(
          title: item['title'],
          description: item['description'],
          price: item['price'],
          imagePath: item['image_path'],
          id: 1,
        );
      }).toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // полный чёрный фон
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Поиск", style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Введите название товара',
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.purpleAccent),
              ),
              onChanged: (value) {
                query = value;
                if (value.isNotEmpty) {
                  searchProducts(value);
                } else {
                  setState(() => searchResults.clear());
                }
              },
            ),
          ),
          if (isLoading)
            const Center(child: CircularProgressIndicator(color: Colors.purple))
          else if (searchResults.isEmpty && query.isNotEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text("Ничего не найдено", style: TextStyle(color: Colors.white70)),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final product = searchResults[index];
                  final imageUrl =
                      'https://ekwknddvmbdzskwytrdm.supabase.co/storage/v1/object/public/images/${product.imagePath}';

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      splashColor: Colors.purple.withOpacity(0.3),
                      highlightColor: Colors.purple.withOpacity(0.15),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(product: product),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.purpleAccent, width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.withOpacity(0.4),
                              offset: const Offset(0, 4),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              imageUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 60,
                                  height: 60,
                                  color: Colors.grey[800],
                                  child: const Icon(Icons.broken_image, color: Colors.white30),
                                );
                              },
                            ),
                          ),
                          title: Text(
                            product.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '${product.price} сум',
                            style: const TextStyle(color: Colors.white70),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.purpleAccent, size: 16),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
