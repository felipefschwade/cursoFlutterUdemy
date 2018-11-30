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
  
  Widget _buildTitleTextField() {
    return TextField(
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
    );
  }

  Widget _buildDescriptionTextField() {
    return TextField(
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
    );
  }

  Widget _buildPriceTextField() {
    return TextField(
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
    );
  }

  void _submitForm() {
    final Map<String, dynamic> product = {
      'title': _title, 
      'price': _price, 
      'description': _description, 
      'image': 'assets/food.jpg'
    };
    widget.addProduct(product);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 768.0 ? 500.0 : MediaQuery.of(context).size.width * 0.85;
    final double targetPadding = deviceWidth - targetWidth;
    return Container(
      margin: EdgeInsets.all(10.0),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
        children: <Widget>[
          _buildTitleTextField(),
          _buildDescriptionTextField(),
          _buildPriceTextField(),
          SizedBox(height:  10.0),
          RaisedButton(
            child: Text('Save'),
            textColor: Colors.white,
            onPressed: _submitForm
          )
        ]),
    );
  }
}