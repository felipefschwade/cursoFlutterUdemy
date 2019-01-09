import 'package:curso_udemy/pages/product_edit.dart';
import 'package:curso_udemy/scoped_models/products.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductListPage extends StatelessWidget {

  Widget _buildEditButton(BuildContext context, int index, ProductsModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectProduct(index);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductEditPage();
          }
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model) {
        return ListView.builder(
          itemCount: model.products.length,
          itemBuilder: (BuildContext context, int index) {
            if (model.products.length > 0) {
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
                  model.selectProduct(index);
                  model.deleteProduct();
                },
                key: UniqueKey(),
                child: Column(children: <Widget>[
                  ListTile(
                    title: Text(model.products[index].title),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(model.products[index].image),
                    ),
                    subtitle: Text('\$ ${model.products[index].price.toString()}'),
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