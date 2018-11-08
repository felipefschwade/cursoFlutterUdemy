import 'package:flutter/material.dart';
import 'package:curso_udemy/products.dart';

class ProductManager extends StatefulWidget {
  final Map<String, String> initialProduct;
  // Named optional argument
  ProductManager({this.initialProduct}){}

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  List<Map<String, String>> _products = [];

  @override
    void initState() {
      super.initState();
      if (widget.initialProduct != null) {
        _products.add(widget.initialProduct);
      }
    }

  void _addProduct(Map<String, String> product) {
      this.setState(() {
        _products.add(product);
      });
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
            onPressed: () => _addProduct({'title': 'Chocolate', 'image' : 'assets/food.jpg'}),
          ),
        ),
        Expanded(child: Products(_products),),
      ],
    );
  }

}