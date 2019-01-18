import 'package:flutter/material.dart';

class Product {
  final String title;
  final String description;
  final double price;
  final String image;
  final bool isFavorite;
  
  Product (
    {@required this.description,
      @required this.image,
      @required this.price,
      @required this.title,
      this.isFavorite = false}); 
}
