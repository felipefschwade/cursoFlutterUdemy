import 'package:curso_udemy/widgets/ui_elements/title.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {

  final String title;
  final String imageUrl;
  final double price;
  final String description;
  final String address;

  ProductPage({this.title, this.imageUrl, this.address, this.description, this.price});

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
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(title),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(Icons.delete_forever),
          onPressed: () => _showWarningDialog(context),
        ),
        body: Column(
          children: <Widget>[
            Image.asset(imageUrl),
            SizedBox(height: 10.0),
            PersonalTitle(title),
            SizedBox(height: 10.0),
            Text(
              '${address} | \$ ${price}',
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 12.0
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

}