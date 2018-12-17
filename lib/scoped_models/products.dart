import 'package:curso_udemy/models/product.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductsModel extends Model {
  List<Product> _products = [];

  List<Product> get products {
    return List.from(_products);
  }

  void _addProduct(Product product) {
    _products.add(product);
  }

   void _updateProduct(int index, Product product) {
    _products[index] = (product);
  }


  void _deleteProduct(int index) {  
    _products.removeAt(index);
  }
}