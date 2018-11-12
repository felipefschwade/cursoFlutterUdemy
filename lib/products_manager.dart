import 'package:flutter/material.dart';
import 'package:curso_udemy/products.dart';

class ProductManager extends StatelessWidget {
  final List<Map<String, String>> products;
  final Function addProduct;
  final Function deleteProduct;


  ProductManager({this.products, this.deleteProduct, this.addProduct});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10.0),
          child: RaisedButton(
            color: Theme.of(context).primaryColor,
            child: Text('Add Product'),
            onPressed: () => addProduct({'title': 'Chocolate', 'image' : 'assets/food.jpg'}),
          ),
        ),
        Expanded(child: Products(products, deleteProduct: deleteProduct),),
      ],
    );
  }

}