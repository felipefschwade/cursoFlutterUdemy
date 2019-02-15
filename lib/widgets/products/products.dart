import 'package:curso_udemy/models/product.dart';
import 'package:curso_udemy/scoped_models/main.dart';
import 'package:curso_udemy/widgets/products/product_card.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Products extends StatelessWidget {
  
  Widget _buildProductList(List<Product> products) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => ProductCard(products[index], index),
      itemCount: products.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return _buildProductList(model.displayedProducts);
      }
    );
  }
}