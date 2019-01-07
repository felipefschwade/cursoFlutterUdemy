import 'package:curso_udemy/models/product.dart';
import 'package:curso_udemy/scoped_models/products.dart';
import 'package:curso_udemy/widgets/ui_elements/title.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductPage extends StatelessWidget {

  final int index;

  ProductPage(this.index);

  void _showWarningDialog(BuildContext context) {
    showDialog(context: context, builder: (BuildContext builder) {
      return AlertDialog(
        title: Text('Are you sure?'),
        content: Text("This change can't be undone."),
        actions: <Widget>[
          FlatButton(child: Text('Discard'), onPressed: () => Navigator.pop(context)),
          FlatButton(
            child: Text('Delete'), 
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, true); 
            }
          ),
        ],
      );
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model) {
        final Product product = model.products[index];
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(product.title),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.red,
            child: Icon(Icons.delete_forever),
            onPressed: () => _showWarningDialog(context),
          ),
          body: Column(
            children: <Widget>[
              Image.asset(product.image),
              SizedBox(height: 10.0),
              PersonalTitle(product.title),
              SizedBox(height: 10.0),
              Text(
                'Endereço louco | \$ ${product.price}',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 12.0
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        );
      }),
    );
  }

}