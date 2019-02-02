import 'package:curso_udemy/models/product.dart';
import 'package:curso_udemy/models/user.dart';
import 'package:http/http.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
mixin ConnectedProducts on Model {
  List<Product> _products = [];
  User _authUser;
  int _selProductIndex;

  void addProduct(String title, String description, double price, String image) async {
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image': 'http://www.luisaabram.com.br/wp-content/uploads/2016/02/ochocolate_barra01-600x478.jpg',
      'price': price
    };
    http.post('https://flutter-products-fcae1.firebaseio.com/products.json', body: json.encode(productData))
    .then((Response res) {
      print(res);
      final Map<String, dynamic> responseData = json.decode(res.body);
      final Product product = Product(title: title, description: description, image: image, price: price, userEmail: _authUser.email, userId: _authUser.id);
      _products.add(product);
      _selProductIndex = null;
      notifyListeners();
    });
  }
}

mixin ProductsModel on ConnectedProducts {

  bool _showFavorites = false;

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  List<Product> get allProducts {
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites) return List.from(_products.where((Product p) => p.isFavorite).toList());
    return List.from(_products);
  }

  Product get selectedProduct {
    if (_selProductIndex == null) return null;
    return _products[_selProductIndex];
  }

  int get selectedProductIndex {
    return _selProductIndex;
  }

   void updateProduct(String title, String description, double price, String image, {bool isFavorite = false}) {
    _products[_selProductIndex] = Product(title: title, description: description, image: image, price: price, isFavorite: isFavorite, userEmail: selectedProduct.userEmail, userId: selectedProduct.userId);
    notifyListeners();
  }

  void toggleProductFavoriteStatus() {
    final bool currentlyFavorite = selectedProduct.isFavorite;
    final bool newFavoriteStatus = !currentlyFavorite;
    updateProduct(
      selectedProduct.title,
      selectedProduct.description,
      selectedProduct.price,
      selectedProduct.image,
      isFavorite: newFavoriteStatus);
    notifyListeners();
  }

  void deleteProduct() {  
    _products.removeAt(selectedProductIndex);
    notifyListeners();
  }

  void selectProduct(int index) {
    _selProductIndex = index;
    if (index != null) {
      notifyListeners();
    }
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}

mixin UserModel on ConnectedProducts {
  void login(String email, String password)
  {
    _authUser = User(id: 'asdasdasd', email: email, password: password);
  }
}