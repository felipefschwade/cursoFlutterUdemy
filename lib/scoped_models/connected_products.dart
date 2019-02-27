import 'package:curso_udemy/models/product.dart';
import 'package:curso_udemy/models/user.dart';
import 'package:http/http.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
mixin ConnectedProducts on Model {
  List < Product > _products = [];
  bool _isLoading = false;
  User _authUser;
  String _selProductId;

}

mixin ProductsModel on ConnectedProducts {

  bool _showFavorites = false;

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  int get selectedProductIndex {
    return _products.indexWhere((Product p) => p.id == _selProductId);
  }

  List<Product> get allProducts {
    return List.from(_products);
  }

  List <Product> get displayedProducts {
    if (_showFavorites) return List.from(_products.where((Product p) => p.isFavorite).toList());
    return List.from(_products);
  }

  Product get selectedProduct {
    if (_selProductId == null) return null;
    return _products.firstWhere((Product p) => p.id == _selProductId);
  }

  String get selectedProductId {
    return _selProductId;
  }

  Future<bool> addProduct(String title, String description, double price, String image) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'price': price,
      'image': 'http://www.luisaabram.com.br/wp-content/uploads/2016/02/ochocolate_barra01-600x478.jpg',
      'userId': _authUser.id,
      'userEmail': _authUser.email
    };
    try {
      final Response res = await http.post('https://flutter-products-fcae1.firebaseio.com/products.json', body: json.encode(productData));
      if (res.statusCode != 200 && res.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      final Map<String, dynamic> responseData = json.decode(res.body);
      final Product product = Product(id: responseData['name'], title: title, description: description, image: image, price: price, userEmail: _authUser.email, userId: _authUser.id);
      _products.add(product);
      _selProductId = null;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateProduct(String title, String description, double price, String image, {
    bool isFavorite = false
  }) {
    _isLoading = true;
    notifyListeners();
    final Map < String, dynamic > updateData = {
      'title': title,
      'description': description,
      'price': price,
      'image': 'http://www.luisaabram.com.br/wp-content/uploads/2016/02/ochocolate_barra01-600x478.jpg',
      'userId': _authUser.id,
      'userEmail': _authUser.email
    };
    return http.put('https://flutter-products-fcae1.firebaseio.com/products/${selectedProduct.id}.json', body: json.encode(updateData))
      .then((Response resp) {
        _isLoading = false;
        _products[selectedProductIndex] = Product(
          id: selectedProduct.id,
          title: title,
          description: description,
          image: image,
          price: price,
          isFavorite: isFavorite,
          userEmail: selectedProduct.userEmail,
          userId: selectedProduct.userId);
        notifyListeners();
        return true;
      })
      .catchError((error) {
        _isLoading = false;
        notifyListeners();
        return false;
      });
  }

  void toggleProductFavoriteStatus() {
    final bool currentlyFavorite = selectedProduct.isFavorite;
    final bool newFavoriteStatus = !currentlyFavorite;
    _products[selectedProductIndex] = Product(
      id: selectedProduct.id,
      title: selectedProduct.title,
      description: selectedProduct.description,
      image: selectedProduct.image,
      price: selectedProduct.price,
      isFavorite: newFavoriteStatus,
      userEmail: selectedProduct.userEmail,
      userId: selectedProduct.userId);
    notifyListeners();
    _selProductId = null;
  }

  Future<bool> deleteProduct() {
    _isLoading = true;
    _products.removeAt(selectedProductIndex);
    notifyListeners();
    return http.delete("https://flutter-products-fcae1.firebaseio.com/products/$_selProductId.json")
      .then((Response resp) {
        _selProductId = null;
        _isLoading = false;
        notifyListeners();
        return true;
      })
      .catchError((error) {
        _selProductId = null;
        _isLoading = false;
        notifyListeners();
        return false;
      });
  }

  Future<Null> fetchProducts() {
    _isLoading = true;
    return http.get('https://flutter-products-fcae1.firebaseio.com/products.json')
      .then < Null > ((Response res) {
        final List < Product > fetchedProducts = [];
        final Map < String, dynamic > productListData = json.decode(res.body);
        if (productListData == null) {
          _isLoading = false;
          notifyListeners();
          return;
        }
        productListData.forEach((String productId, dynamic item) {
          final Product product = Product(
            id: productId,
            description: item['description'],
            image: item['image'],
            price: item['price'],
            title: item['title'],
            userEmail: item['userEmail'],
            userId: item['userId']
          );
          fetchedProducts.add(product);
        });
        _products = fetchedProducts;
        _isLoading = false;
        notifyListeners();
        _selProductId = null;
        return;
      })
      .catchError((error) {
        _isLoading = false;
        notifyListeners();
        return;
      });
  }

  void selectProduct(String productId) {
    _selProductId = productId;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}

mixin UserModel on ConnectedProducts {
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      _isLoading = true;
      final Map<String, String> formData = {
        'email': email,
        'password': password,
      };
      final Response response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyBZYJ9zzu_XeC9hZrbOqXyIa7iEhCfbHj8',
        body: json.encode(formData),
        headers: {'Content-Type': 'application/json'}
      );
      final Map<String, dynamic> responseData = json.decode(response.body);
      _isLoading = false;
      notifyListeners();
      if (response.statusCode != 200 && response.statusCode != 201) {
        String message = 'Ops, something went wrong!';
        if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') message = 'This email was not found.';
        else if (responseData['error']['message'] == 'INVALID_PASSWORD') message = 'The password is invalid.';
        return {'success': false, 'message': message};
      }
      return {'success': true, 'message': 'Authentication Succeeded!'}; 
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return {'success': false, 'message': 'Ops, something went wrong!'}; 
    }
  }

  Future<Map<String, dynamic>> signUp(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, String> formData = {
      'email': email,
      'password': password,
    };
    try {
      final Response response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyBZYJ9zzu_XeC9hZrbOqXyIa7iEhCfbHj8',
        body: json.encode(formData),
        headers: {'Content-Type': 'application/json'}
      );
      _isLoading = false;
      notifyListeners();
      final Map<String, dynamic> responseData =json.decode(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        String message = 'Ops, something went wrong!';
        if (responseData['error']['message'] == 'EMAIL_EXISTS') message = 'This email already exists.';
        return {'success': false, 'message': message};
      }
      return {'success': true, 'message': 'Authentication Succeeded!'}; 
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return {'success': false, 'message': 'Ops, something went wrong!'}; 
    }
  }

}

mixin UtilityModel on ConnectedProducts {
  bool get isLoading {
    return _isLoading;
  }
}