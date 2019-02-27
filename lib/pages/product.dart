import 'package:curso_udemy/models/product.dart';
import 'package:curso_udemy/widgets/ui_elements/title.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final Product product;

  ProductPage(this.product);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(product.title),
      ),
      body: Column(
        children: <Widget>[
          Image.network(product.image),
          SizedBox(height: 10.0),
          PersonalTitle(product.title),
          SizedBox(height: 10.0),
          Text(
            'Endereço louco | \$ ${product.price}',
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 12.0
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              product.description,
              style: TextStyle(
                fontSize: 18.0,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

}