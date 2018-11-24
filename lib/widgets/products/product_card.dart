import 'package:curso_udemy/widgets/products/price_tag.dart';
import 'package:curso_udemy/widgets/ui_elements/title.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {

  final Map<String, dynamic> product;
  final int index;

  ProductCard(this.product, this.index);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(product['image']),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                PersonalTitle(product['title']),
                SizedBox(width: 8.0),
                PriceTag(price: product['price'].toString()),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical:  2.5),
            child: Text('Union Square - San Francisco'),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0
              ),
              borderRadius: BorderRadius.circular(5.0)
            ),
          ),
          Text(product['description']),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                color: Theme.of(context).primaryColor,
                icon: Icon(Icons.info),
                iconSize: 40.0,
                onPressed: () => Navigator.pushNamed<bool>(context, '/product/${index.toString()}')
              ),
              IconButton(
                icon: Icon(Icons.favorite_border),
                color: Colors.red,
                iconSize: 40.0,
                onPressed: () {},
              ),
            ],
          )
        ]),
    );;
  }

}