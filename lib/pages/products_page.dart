import 'package:curso_udemy/drawer.dart';
import 'package:curso_udemy/products_manager.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text('EasyList'),
        ),
        body: ProductManager()
    );
  }

}