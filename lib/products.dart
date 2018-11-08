import 'package:curso_udemy/pages/product.dart';
import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<Map<String, String>> products;
  // Positional optional argument
  Products([this.products = const []]){}

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products[index]['image']),
          Text(products[index]['title']),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('Details'),
                onPressed: () => Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (BuildContext context) => ProductPage(title: products[index]['title'], imageUrl: products[index]['image'],)
                  )),  
              )
            ],
          )
        ]),
    );
  }

  Widget _buildProductList() {
    if (products.length > 0) {
      return ListView.builder(
        itemBuilder: _buildProductItem,
        itemCount: products.length,
      );
    }
    return Center(child: Text('No products Found!'),);
  }

  @override
  Widget build(BuildContext context) {
    return _buildProductList();
  }
}