
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Product Detail'),
        ),
        body: Center(child: Text('On product page'),)
    );
  }

}