import 'package:curso_udemy/drawer.dart';
import 'package:curso_udemy/pages/product_create.dart';
import 'package:curso_udemy/pages/product_list.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  final Function addProduct;
  final Function deleteProduct;

  AdminPage(this.addProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Manage products'),
          bottom: TabBar(
            indicatorColor: Theme.of(context).accentColor,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.create),
                text: 'Create Product',
              ),
              Tab(
                icon: Icon(Icons.list),
                text: 'My Products',
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ProductCreatePage(addProduct),
            ProductListPage(),
          ],
        )
      ),
    ); 
  }

}