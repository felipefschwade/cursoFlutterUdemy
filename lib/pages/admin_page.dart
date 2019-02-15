import 'package:curso_udemy/drawer.dart';
import 'package:curso_udemy/pages/product_edit.dart';
import 'package:curso_udemy/pages/product_list.dart';
import 'package:curso_udemy/scoped_models/main.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  final MainModel model;

  AdminPage(this.model);

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
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ProductEditPage(),
            ProductListPage(this.model),
          ],
        )
      ),
    ); 
  }

}