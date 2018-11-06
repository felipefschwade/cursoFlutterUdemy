import 'package:flutter/material.dart';
import 'package:curso_udemy/products.dart';

class ProductManager extends StatefulWidget {
  final String initialProduct;
  // Named optional argument
  ProductManager({this.initialProduct = 'No name Tester'}){}

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  List<String> _products = [];

  @override
    void initState() {
      super.initState();
      _products.add(widget.initialProduct);
    }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10.0),
          child: RaisedButton(
            color: Theme.of(context).primaryColor,
            child: Text('Add Product'),
            onPressed: () {
              this.setState(() {
                _products.add('Avanced Food Tester');
              });
            },
          ),
        ),
        Expanded(child: Products(_products),),
      ],
    );
  }

}