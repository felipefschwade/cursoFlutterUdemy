import 'package:curso_udemy/drawer.dart';
import 'package:curso_udemy/products_manager.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {
  final List<Map<String, String>> products;
  final Function addProduct;
  final Function deleteProduct;

  ProductsPage(this.products, this.addProduct, this.deleteProduct);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text('EasyList'),
        ),
        body: ProductManager(products: products, addProduct: addProduct, deleteProduct: deleteProduct,)
    );
  }

}