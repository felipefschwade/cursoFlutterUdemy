
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {

  final String title;
  final String imageUrl;

  ProductPage({this.title, this.imageUrl}){}

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(imageUrl),
            Container(child: Padding(padding: EdgeInsets.all(10.0), child:  Text('On product page'),),),
            Container(
              child: Padding(
                padding: EdgeInsets.all(10.0), 
                child:  RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Text('Delete'), 
                  onPressed: () => _showWarningDialog(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}