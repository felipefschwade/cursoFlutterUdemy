import 'package:curso_udemy/models/product.dart';
import 'package:curso_udemy/pages/product_edit.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  final List<Product> products;
  final Function updateProduct;
  final Function deleteProduct;

  ProductListPage(this.products, this.updateProduct, this.deleteProduct);

  Widget _buildEditButton(BuildContext context, int index) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductEditPage(product: products[index], updateProduct: updateProduct, index: index);
          }
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        if (products.length > 0) {
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
              deleteProduct(index);
            },
            key: UniqueKey(),
            child: Column(children: <Widget>[
              ListTile(
                title: Text(products[index].title),
                leading: CircleAvatar(
                  backgroundImage: AssetImage(products[index].image),
                ),
                subtitle: Text('\$ ${products[index].price.toString()}'),
                trailing: _buildEditButton(context, index),
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
  
}