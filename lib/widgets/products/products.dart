import 'package:curso_udemy/models/product.dart';
import 'package:curso_udemy/widgets/products/product_card.dart';
import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<Product> products;

  // Positional optional argument
  Products(this.products);
  
  Widget _buildProductList() {
    if (products.length > 0) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) => ProductCard(products[index], index),
        itemCount: products.length,
      );
    }
    return Center(child: Text('No products Found!'),);
  }

  @override
  Widget build(BuildContext context) {
    return _buildProductList();
  }
}