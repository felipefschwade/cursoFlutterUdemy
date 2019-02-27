import 'package:curso_udemy/models/product.dart';
import 'package:curso_udemy/scoped_models/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductEditPage extends StatefulWidget {
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
  
  Widget _buildTitleTextField(Product product) {
    return TextFormField(
      autovalidate: true,
      initialValue: product == null ? '' : product.title,
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

  Widget _buildDescriptionTextField(Product product) {
    return TextFormField(
      initialValue: product == null ? '' : product.description,
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

  Widget _buildPriceTextField(Product product) {
    return TextFormField(
      initialValue: product == null ? '' : product.price.toString(),
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

  void _submitForm(Function addProduct, Function updateProduct, Function setSelectedProduct, [int selectedProductIndex]) async {
    // Usage without autovalidate.
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    print(selectedProductIndex);
    if (selectedProductIndex == -1) {
      try {
        final bool success = await addProduct(
          _formData['title'],
          _formData['description'],
          _formData['price'],
          'assets/food.jpg',
        );
        if (success) Navigator.pushReplacementNamed(context, '/products').then((_) => setSelectedProduct(null));
        else Scaffold.of(context).showSnackBar(SnackBar(content: Text('Something went wrong! Please try again later.')));
      } catch (e) {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Something went wrong! Please try again later.')));
      }
    } else {
      updateProduct(
          _formData['title'],
          _formData['description'],
          _formData['price'],
          'assets/food.jpg',
      ).then((bool success) {
        if (success) Navigator.pushReplacementNamed(context, '/products').then((_) => setSelectedProduct(null));
        else Scaffold.of(context).showSnackBar(SnackBar(content: Text('Something went wrong! Please try again later.')));
      });
    }
    
  }

  Widget _buildPageContent(BuildContext context, Product product) {
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
              _buildTitleTextField(product),
              _buildDescriptionTextField(product),
              _buildPriceTextField(product),
              SizedBox(height:  10.0),
              _buildSubmitButton(),
            ]
          ),
        ),
      ),
    ); 
    return content;
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading ? Center(child: CircularProgressIndicator()) : RaisedButton(
          child: Text('Save'),
          textColor: Colors.white,
          onPressed: () => _submitForm(model.addProduct, model.updateProduct, model.selectProduct, model.selectedProductIndex),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget content = _buildPageContent(context, model.selectedProduct);
        return model.selectedProductIndex == -1 ? content : Scaffold(appBar: AppBar(title: Text('Edit Product')), body: content,);
      }
    );
  }

}