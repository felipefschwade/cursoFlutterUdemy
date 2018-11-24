import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;

  ProductCreatePage(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductCreateState();
  }
  
}

class _ProductCreateState extends State<ProductCreatePage> {
  String _title = "";
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
              _title = value;   
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
        SizedBox(height:  10.0),
        RaisedButton(
          child: Text('Save'),
          textColor: Colors.white,
          color: Theme.of(context).primaryColor,
          onPressed: () {
            Map<String, dynamic> product = {'title': _title, 'price': _price, 'description': _description, 'image': 'assets/food.jpg'};
            widget.addProduct(product);
            Navigator.pushReplacementNamed(context, '/products');
          }
        )
      ]),
    );
  }
}