import 'package:curso_udemy/pages/admin_page.dart';
import 'package:curso_udemy/pages/auth.dart';
import 'package:curso_udemy/pages/product.dart';
import 'models/product.dart';
import 'package:curso_udemy/pages/products_page.dart';
import 'package:curso_udemy/scoped_models/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(new App());

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }

}

class _AppState extends State<App> {
  final MainModel _model = MainModel();
  bool _isAuthenticated = false;

  @override
  void initState() {
    _model.autoAuth();
    _model.userSubject.listen((bool isAuthenticated) {
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return ScopedModel<MainModel>( 
      model: _model,
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.orange,
          accentColor: Colors.purple,
          errorColor: Colors.red,
          buttonColor: Colors.orange,
          primaryIconTheme: IconThemeData(
            color: Colors.white
          ),
          primaryTextTheme: TextTheme(
            title: TextStyle(color: Colors.white),
            button: TextStyle(color: Colors.white),
          )
        ),
        routes: {
          '/': (BuildContext context) => !_isAuthenticated ? AuthPage() : ProductsPage(_model),
          '/admin' : (BuildContext context) => !_isAuthenticated ? AuthPage() : AdminPage(_model),
        },
        onGenerateRoute: (RouteSettings settings) {
          if (!_isAuthenticated) {
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) =>  AuthPage()
            );
          }
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'product') {
            final String productId =  pathElements[2];
            final product = _model.allProducts.firstWhere((Product p) => p.id == productId);
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ProductPage(product)
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) => !_isAuthenticated ? AuthPage() : ProductsPage(_model)
          );
        },
      ),
    );
  }
}