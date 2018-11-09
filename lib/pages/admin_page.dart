import 'package:curso_udemy/drawer.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Administrator Page'),
        ),
        body: Center(
          child: Text('Admin Page'),
        )
    );
  }

}