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
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg',
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  Widget _buildTitleTextField() {
    return TextFormField(
      autovalidate: true,
      decoration: InputDecoration(
        labelText: 'Product Title',
        icon: Icon(Icons.perm_identity),
      ),
      onSaved: (String value) {
       _formData['title'] = value;
      },
      validator: (String value) {
        if (value.isEmpty) return "Title is required.";
        if (value.length <= 4) return "Title must have at least 5 characters.";
        return null;
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      autovalidate: true,
        decoration: InputDecoration(
        labelText: 'Product Description',
        icon: Icon(Icons.description),
      ),
      autocorrect: true,
      maxLines: 5,
      onSaved: (String value) {
        _formData['description'] = value;
      },
      validator: (String value) {
        if (value.isEmpty) return "Description is required.";
        if (value.length <= 4) return "Description must have at least 5 characters.";
        return null;
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      autovalidate: true,
      decoration: InputDecoration(
        labelText: 'Product price',
        icon: Icon(Icons.monetization_on),
      ),
      autocorrect: true,
      keyboardType: TextInputType.number,
      onSaved: (String value) {
        String newValue = value.replaceAll(",", ".");
        _formData['price'] = double.parse(newValue);
      },
      validator: (String value) {
        String newValue = value.replaceAll(",", ".");
        if (newValue.isEmpty) return "Price is required.";
        if (double.parse(newValue) < 1) return "Price must not be less than 1\$.";
        return null;
      },
    );
  }

  void _submitForm() {
    // Usage without autovalidate.
    // if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    widget.addProduct(_formData);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 768.0 ? 500.0 : MediaQuery.of(context).size.width * 0.85;
    final double targetPadding = deviceWidth - targetWidth;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
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
            ]
          ),
        ),
      ),
    );
  }
}