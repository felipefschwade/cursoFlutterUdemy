import 'package:curso_udemy/models/product.dart';
import 'package:scoped_model/scoped_model.dart';

mixin ProductsModel on Model {
  List<Product> _products = [];
  int _selectedProductIndex;

  bool _showFavorites = false;

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  List<Product> get products {
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites) return List.from(_products.where((Product p) => p.isFavorite).toList());
    return List.from(_products);
  }

  Product get selectedProduct {
    if (_selectedProductIndex == null) return null;
    return _products[_selectedProductIndex];
  }

  int get selectedProductIndex {
    return _selectedProductIndex;
  }

  void addProduct(Product product) {
    _products.add(product);
    _selectedProductIndex = null;
    notifyListeners();
  }

   void updateProduct(Product product) {
    _products[_selectedProductIndex] = product;
    _selectedProductIndex = null;
    notifyListeners();
  }

  void toggleProductFavoriteStatus() {
    final bool currentlyFavorite = selectedProduct.isFavorite;
    final bool newFavoriteStatus = !currentlyFavorite;
    Product updatedProcut = new Product(
      title: selectedProduct.title,
      description: selectedProduct.description,
      image: selectedProduct.image,
      price: selectedProduct.price,
      isFavorite: newFavoriteStatus
    );
    updateProduct(updatedProcut);
    notifyListeners();
    _selectedProductIndex = null;
  }

  void deleteProduct() {  
    _products.removeAt(_selectedProductIndex);
    _selectedProductIndex = null;
    notifyListeners();
  }

  void selectProduct(int index) {
    _selectedProductIndex = index;
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}