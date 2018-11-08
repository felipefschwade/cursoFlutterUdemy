
import 'package:curso_udemy/products_manager.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('EasyList'),
        ),
        body: ProductManager()
    );
  }

}