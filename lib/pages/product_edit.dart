import 'package:curso_udemy/models/product.dart';
import 'package:flutter/material.dart';

class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Product product;
  final int index;

  ProductEditPage({this.addProduct, this.index, this.product, this.updateProduct});

  @override
  State<StatefulWidget> createState() {
    return _ProductEditState();
  }
  
}

class _ProductEditState extends State<ProductEditPage> {
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
      initialValue: widget.product == null ? '' : widget.product.title,
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
      initialValue: widget.product == null ? '' : widget.product.description,
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
      initialValue: widget.product == null ? '' : widget.product.price.toString(),
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
    if (widget.product == null) {
      widget.addProduct(
        Product(
          title: _formData['title'],
          description: _formData['description'],
          image: 'assets/food.jpg',
          price: _formData['price']
        )
      );
    } else {
      widget.updateProduct(
        widget.index, 
        Product(
          title: _formData['title'],
          description: _formData['description'],
          image: 'assets/food.jpg',
          price: _formData['price']
        )
      );
    }
    Navigator.pushReplacementNamed(context, '/products');
  }

  Widget _buildPageContent(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 768.0 ? 500.0 : MediaQuery.of(context).size.width * 0.85;
    final double targetPadding = deviceWidth - targetWidth;
    final Widget content = GestureDetector(
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
    return content;
  }

  @override
  Widget build(BuildContext context) {
    Widget content = _buildPageContent(context);
    return widget.product == null ? content : Scaffold(appBar: AppBar(title: Text('Edit Product')), body: content,);
  }

}