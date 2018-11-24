import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {

  final String price;

  PriceTag({this.price});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Theme.of(context).accentColor
      ),
      child: Text(
        '\$ ${price}',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0
        ),
      ),
    );
  }

}