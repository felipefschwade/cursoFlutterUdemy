import 'package:curso_udemy/models/auth.dart';
import 'package:curso_udemy/models/location_data.dart';
import 'package:curso_udemy/models/product.dart';
import 'package:curso_udemy/models/user.dart';
import 'package:http/http.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:curso_udemy/env.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

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

  Future<bool> addProduct(String title, String description, double price, String image, LocationData locData) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'price': price,
      'image': 'http://www.luisaabram.com.br/wp-content/uploads/2016/02/ochocolate_barra01-600x478.jpg',
      'userId': _authUser.id,
      'userEmail': _authUser.email,
      'loc_lat': locData.latitude,
      'loc_lng': locData.longitude,
      'loc_address': locData.address,
    };
    try {
      final Response res = await http.post('https://flutter-products-fcae1.firebaseio.com/products.json', body: json.encode(productData));
      if (res.statusCode != 200 && res.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      final Map<String, dynamic> responseData = json.decode(res.body);
      final Product product = Product(
        id: responseData['name'], 
        title: title, 
        description: description,
        image: image, 
        price: price,
        userEmail: _authUser.email, 
        userId: _authUser.id,
        location: locData);
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

  Future<bool> updateProduct(String title, String description, double price, String image, LocationData locData, {
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
      'loc_lat': locData.latitude,
      'loc_lng': locData.longitude,
      'loc_address': locData.address,
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

  void toggleProductFavoriteStatus() async {
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
    Response resp;
    if (newFavoriteStatus) {
        resp = await http.put('https://flutter-products-fcae1.firebaseio.com/products/${selectedProduct.id}/wishListUsers/${_authUser.id}.json',
        body: json.encode(true)
      );
    } else {
      resp = await http.delete(
        'https://flutter-products-fcae1.firebaseio.com/products/${selectedProduct.id}/wishListUsers/${_authUser.id}.json'
      );
    }
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      _products[selectedProductIndex] = Product(
        id: selectedProduct.id,
        title: selectedProduct.title,
        description: selectedProduct.description,
        image: selectedProduct.image,
        price: selectedProduct.price,
        isFavorite: !newFavoriteStatus,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId);
        notifyListeners();
    }
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

  Future<Null> fetchProducts({bool onlyForUser = false}) {
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
            location: LocationData(
              address: item['loc_address'], 
              latitude: item['loc_lat'], 
              longitude: item['loc_lng']),
            userEmail: item['userEmail'],
            userId: item['userId'],
            isFavorite: item['wishListUsers'] == null ? false :
              (item['wishListUsers'] as Map<String, dynamic>).containsKey(_authUser.id)
          );
          fetchedProducts.add(product);
        });
        _products = !onlyForUser ? fetchedProducts : _products =fetchedProducts.where((Product p) => p.userId ==_authUser.id).toList();
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
    if (productId == null) {
      return;
    }
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}

mixin UserModel on ConnectedProducts {
  Timer _authTimer;
  PublishSubject<bool> _userSubject = PublishSubject();

  User get authUser {
    return _authUser;
  }

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  Future<Map<String, dynamic>> authenticate(String email, String password, [AuthMode mode = AuthMode.Login]) async {
    try {
      _isLoading = true;
      final Map<String, String> formData = {
        'email': email,
        'password': password
      };
      Response response;
      if (mode == AuthMode.Login) {
        response = await http.post(
          'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=${Env.env['apiKey']}',
          body: json.encode(formData),
          headers: {'Content-Type': 'application/json'}
        );
      } else {
        response = await http.post(
          'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=${Env.env['apiKey']}',
          body: json.encode(formData),
          headers: {'Content-Type': 'application/json'}
        );
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      _isLoading = false;
      notifyListeners();
      if (response.statusCode != 200 && response.statusCode != 201 && !responseData.containsKey('idToken')) {
        String message = 'Ops, something went wrong!';
        if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') message = 'This email was not found.';
        else if (responseData['error']['message'] == 'INVALID_PASSWORD') message = 'The password is invalid.';
        else if (responseData['error']['message'] == 'EMAIL_EXISTS') message = 'This email already exists.';
        return {'success': false, 'message': message};
      }
      _authUser = User(id: responseData['localId'], email: email, token: responseData['idToken']);
      _userSubject.add(true);
      final int expiration = 3600;
      final DateTime now = DateTime.now();
      final DateTime expireTime = now.add(Duration(seconds: expiration));
      this.setAuthTimeout(expiration);
      final SharedPreferences prefs =  await SharedPreferences.getInstance();
      prefs.setString('token', responseData['idToken']);
      prefs.setString('userEmail', email);
      prefs.setString('userId', responseData['localId']);
      prefs.setString('expireTime', expireTime.toIso8601String());
      return {'success': true, 'message': 'Authentication Succeeded!'}; 
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return {'success': false, 'message': 'Ops, something went wrong!'}; 
    }
  }

  void autoAuth() async {
    final SharedPreferences prefs =  await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    final String expiryString = prefs.getString('expireTime');
    if (token != null) {
      final DateTime now = DateTime.now();
      final DateTime parsedExpiryTime = DateTime.parse(expiryString);
      if (parsedExpiryTime.isBefore(now)) {
        _authUser = null;
        return;
      }
      final String email = prefs.getString('userEmail');
      final String userId = prefs.getString('userId');
      final int tokenLifeTime = parsedExpiryTime.difference(now).inSeconds;
      _authUser = User(email: email, id: userId, token: token);
      _userSubject.add(true);
      this.setAuthTimeout(tokenLifeTime);
      notifyListeners();
    }
  }

  void logout() async {
    _authUser = null;
    _authTimer.cancel();
    _userSubject.add(false);
    final SharedPreferences prefs =  await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('userEmail');
    await prefs.remove('userId');
  }

  void setAuthTimeout(int time) {
    _authTimer = Timer(Duration(seconds: time), logout);
  }

}

mixin UtilityModel on ConnectedProducts {
  bool get isLoading {
    return _isLoading;
  }
}