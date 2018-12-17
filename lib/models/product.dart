import 'package:flutter/material.dart';

class Product {
  final String title;
  final String description;
  final double price;
  final String image;
  
  Product (
      {@required this.description,
       @required this.image,
       @required this.price,
       @required this.title}); 
}