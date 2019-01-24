import 'package:curso_udemy/models/product.dart';
import 'package:curso_udemy/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

mixin ConnectedProducts on Model {
  List<Product> products = [];
  User authUser;
  int selProductIndex;

  void addProduct(String title, String description, double price, String image) {
    final Product product = Product(title: title, description: description, image: image, price: price, userEmail: authUser.email, userId: authUser.id);
    products.add(product);
    selProductIndex = null;
    notifyListeners();
  }
}