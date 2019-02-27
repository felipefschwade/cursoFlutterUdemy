import 'package:curso_udemy/models/product.dart';
import 'package:curso_udemy/scoped_models/main.dart';
import 'package:curso_udemy/widgets/products/price_tag.dart';
import 'package:curso_udemy/widgets/products/product_tag.dart';
import 'package:curso_udemy/widgets/ui_elements/title.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductCard extends StatelessWidget {

  final Product product;
  final int index;

  ProductCard(this.product, this.index);

  Widget _buildPriceRow() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          PersonalTitle(product.title),
          SizedBox(width: 8.0),
          PriceTag(price: product.price.toString()),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              color: Theme.of(context).primaryColor,
              icon: Icon(Icons.info),
              iconSize: 40.0,
              onPressed: () => Navigator.pushNamed<bool>(context, '/product/${model.allProducts[index].id}')
            ),
            IconButton(
              icon: Icon(model.allProducts[index].isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Colors.red,
              onPressed: () {
                model.selectProduct(model.allProducts[index].id);
                model.toggleProductFavoriteStatus();
              },
            ),
          ],
        );
      },
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage(product.image), 
            placeholder: AssetImage('assets/background.jpg'),
            height: 300.0,
            fit: BoxFit.cover,
          ),
          _buildPriceRow(),
          ProductTag('Union Square - San Francisco'),
          Text(product.userEmail),
          Text(product.description),
          _buildActionButtons(context),
        ]),
    );
  }

}