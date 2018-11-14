import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductCreateState();
  }
  
}

class _ProductCreateState extends State<ProductCreatePage> {
  String _text = "";
  String _description = "";
  double _price = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: ListView(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            labelText: 'Product Title',
            icon: Icon(Icons.perm_identity),
          ),
          autocorrect: true,
          onChanged: (String value) {
            setState(() {
              _text = value;   
            });
          },
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Product Description',
            icon: Icon(Icons.description),
          ),
          autocorrect: true,
          maxLines: 5,
          onChanged: (String value) {
            setState(() {
              _description = value;   
            });
          },
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Product price',
            icon: Icon(Icons.monetization_on),
          ),
          autocorrect: true,
          keyboardType: TextInputType.number,
          onChanged: (String value) {
            setState(() {
              _price = double.parse(value);   
            });
          },
        ),
        RaisedButton(
          child: Text('Save'),
          onPressed: () {
            
          },
        )
      ]),
    );
  }
}