import 'package:curso_udemy/widgets/ui_elements/logout_list_tile.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.menu),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            centerTitle: true,
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.create),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.pushNamed(context, "/admin");
            },
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('All Products'),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/products");
            },
          ),
          Divider(),
          LogoutListTile()
        ],
      ),
    );
  }
}
