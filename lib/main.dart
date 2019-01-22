import 'package:curso_udemy/pages/admin_page.dart';
import 'package:curso_udemy/pages/auth.dart';
import 'package:curso_udemy/pages/product.dart';
import 'package:curso_udemy/pages/products_page.dart';
import 'package:curso_udemy/scoped_models/main.dart';
import 'package:curso_udemy/scoped_models/products.dart';
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
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>( 
      model: MainModel(),
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
        home: AuthPage(),
        routes: {
          '/products' : (BuildContext context) => ProductsPage(),
          '/admin' : (BuildContext context) => AdminPage(),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'product') {
            final int index = int.parse(pathElements[2]);
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ProductPage(index)
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(builder: (BuildContext context) => ProductsPage());
        },
      ),
    );
  }
}