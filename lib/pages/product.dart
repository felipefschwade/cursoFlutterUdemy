
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {

  final String title;
  final String imageUrl;

  ProductPage({this.title, this.imageUrl}){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Text('back'), 
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
    );
  }

}