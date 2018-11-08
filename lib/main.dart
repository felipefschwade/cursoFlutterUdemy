import 'package:curso_udemy/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:curso_udemy/products_manager.dart';

void main() => runApp(new App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.orange,
        accentColor: Colors.greenAccent,
      ),
      home: HomePage(),
    );
  }
}