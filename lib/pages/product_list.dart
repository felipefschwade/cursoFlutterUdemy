import 'package:curso_udemy/pages/product_edit.dart';
import 'package:curso_udemy/scoped_models/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductListPage extends StatefulWidget { 

  final MainModel model;

  ProductListPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ProductsLisState();
  }
}

class _ProductsLisState extends State<ProductListPage> {

  @override
  void initState() {
    widget.model.fetchProducts();
    super.initState();
  }

  void _showWarningDialog(BuildContext context, MainModel model, int index) {
    showDialog(context: context, builder: (BuildContext builder) {
      return AlertDialog(
        title: Text('Are you sure?'),
        content: Text("This change can't be undone."),
        actions: <Widget>[
          FlatButton(child: Text('Discard'), onPressed: () {
            Navigator.pop(context);
          }),
          FlatButton(
            child: Text('Delete'), 
            onPressed: () {
              model.selectProduct(model.allProducts[index].id);
              model.deleteProduct()
              .then((bool success) {
                if (success) Navigator.pop(context);
                else Scaffold.of(context).showSnackBar(SnackBar(content: Text('Something went wrong! Please try again later.')));
              });              
            }
          ),
        ],
      );
    }); 
  }

  Widget _buildEditButton(BuildContext context, int index, MainModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectProduct(model.allProducts[index].id);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductEditPage();
          }
        )).then((_) => model.selectProduct(null));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ListView.builder(
          itemCount: model.allProducts.length,
          itemBuilder: (BuildContext context, int index) {
            if (model.allProducts.length > 0) {
              return Dismissible(
                background: Container(
                  color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Icon(Icons.delete, color: Colors.white, size: 36,),
                      SizedBox(width: 20.0,)
                    ],
                  ),
                ),
                onDismissed: (DismissDirection direction) {
                  _showWarningDialog(context, model, index);
                },
                key: UniqueKey(),
                child: Column(children: <Widget>[
                  ListTile(
                    title: Text(model.allProducts[index].title),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(model.allProducts[index].image),
                    ),
                    subtitle: Text('\$ ${model.allProducts[index].price.toString()}'),
                    trailing: _buildEditButton(context, index, model),
                  ),
                  Divider()
                ]),
                direction: DismissDirection.endToStart, 
              );
            }
            return Center(child: Text("No data founde"));
          },
        );
      }
    );
  }
  
}