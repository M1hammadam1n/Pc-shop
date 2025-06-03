import 'package:flutter/material.dart';
import 'package:pc_shop/components/Product/Product_Detail_Page.dart';
import 'package:pc_shop/service/product.dart';
import 'package:pc_shop/theme/app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
        .ilike('title', '%$text%');

    final data = response as List<dynamic>;

    setState(() {
      searchResults = data.map((item) {
        return Product(
          title: item['title'],
          description: item['description'],
          price: item['price'],
          imagePath: item['image_path'],
          id: item['id'] ?? 0,
        );
      }).toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 600;

    return Scaffold(
      backgroundColor: AppTheme.black70,
      appBar: AppBar(
        backgroundColor: AppTheme.black70,
        title: const Text("Поиск", style: TextStyle(color: AppTheme.white)),
        elevation: 0,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    style: const TextStyle(color: AppTheme.white),
                    decoration: InputDecoration(
                      hintText: 'Введите название товара',
                      hintStyle: const TextStyle(color: AppTheme.white54),
                      filled: true,
                      fillColor: AppTheme.black80,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.search, color: AppTheme.purpleAccent),
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
                  const Center(
                      child: CircularProgressIndicator(color: AppTheme.purple))
                else if (searchResults.isEmpty && query.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text("Ничего не найдено",
                        style: TextStyle(color: AppTheme.white70)),
                  )
                else if (searchResults.isEmpty && query.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text("Введите название товара для поиска",
                        style: TextStyle(color: AppTheme.white54, fontStyle: FontStyle.italic)),
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
                            splashColor: AppTheme.purple.withOpacity(0.3),
                            highlightColor: AppTheme.purple.withOpacity(0.15),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailPage(product: product),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF2A2A2A), 
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: AppTheme.purpleAccent, width: 1.5),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.purple.withOpacity(0.5),
                                    offset: const Offset(0, 4),
                                    blurRadius: 12,
                                  ),
                                ],
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(12),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    imageUrl,
                                    width: isWide ? 80 : 60,
                                    height: isWide ? 80 : 60,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: isWide ? 80 : 60,
                                        height: isWide ? 80 : 60,
                                        color: AppTheme.gray,
                                        child: const Icon(Icons.broken_image,
                                            color: AppTheme.White30),
                                      );
                                    },
                                  ),
                                ),
                                title: Text(
                                  product.title,
                                  style: TextStyle(
                                    color: AppTheme.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: isWide ? 18 : 16,
                                  ),
                                ),
                                subtitle: Text(
                                  '${product.price} сум',
                                  style: TextStyle(
                                    color: AppTheme.white70,
                                    fontSize: isWide ? 16 : 14,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppTheme.purpleAccent,
                                  size: isWide ? 18 : 16,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
