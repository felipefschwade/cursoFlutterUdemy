import 'package:curso_udemy/pages/product.dart';
import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  // Positional optional argument
  Products(this.products);

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products[index]['image']),
          Text(products[index]['title']),
          Text(products[index]['description']),
          Text(products[index]['price'].toString()),
        ]),
    );
  }

  Widget _buildProductList() {
    if (products.length > 0) {
      return ListView.builder(
        itemBuilder: _buildProductItem,
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