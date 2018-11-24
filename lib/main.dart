import 'package:curso_udemy/pages/admin_page.dart';
import 'package:curso_udemy/pages/auth.dart';
import 'package:curso_udemy/pages/product.dart';
import 'package:curso_udemy/pages/products_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(new App());

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }

}

class _AppState extends State<App> {
  List<Map<String, dynamic>> _products = [];

  void _addProduct(Map<String, dynamic> product) {
      this.setState(() {
        _products.add(product);
      });
  }

  void _deleteProduct(int index) {
    this.setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.orange,
        accentColor: Colors.purple,
        errorColor: Colors.red,
        primaryIconTheme: IconThemeData(
          color: Colors.white
        ),
        primaryTextTheme: TextTheme(
          title: TextStyle(color: Colors.white)
        )
      ),
      home: AuthPage(),
      routes: {
        '/products' : (BuildContext context) => ProductsPage(_products),
        '/admin' : (BuildContext context) => AdminPage( _addProduct, _deleteProduct),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'product') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => ProductPage(
              title: _products[index]['title'], 
              imageUrl: _products[index]['image'],
              address: 'Union Square - San Francisco',
              description: _products[index]['description'],
              price: _products[index]['price'],)
          );
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) => ProductsPage(_products));
      },
    );
  }
}