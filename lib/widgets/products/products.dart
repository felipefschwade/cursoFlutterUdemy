import 'package:curso_udemy/models/product.dart';
import 'package:curso_udemy/scoped_models/products.dart';
import 'package:curso_udemy/widgets/products/product_card.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Products extends StatelessWidget {
  
  Widget _buildProductList(List<Product> products) {
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
    return ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model) {
        return _buildProductList(model.products);
      }
    );
  }
}