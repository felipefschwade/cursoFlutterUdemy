import 'package:curso_udemy/drawer.dart';
import 'package:curso_udemy/scoped_models/main.dart';
import 'package:curso_udemy/widgets/products/products.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text('EasyList'),
          actions: <Widget>[
            ScopedModelDescendant<MainModel>(
              builder: (BuildContext context, Widget child, MainModel model) {
                return IconButton(
                  icon: Icon(model.displayFavoritesOnly ? Icons.favorite : Icons.favorite_border),
                  onPressed: () {
                    model.toggleDisplayMode();
                  },
                );
              }
            ),
          ],
        ),
        body: Products()
    );
  }

}