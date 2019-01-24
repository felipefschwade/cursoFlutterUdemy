import 'package:curso_udemy/models/product.dart';
import 'package:curso_udemy/scoped_models/connected_products.dart';

mixin ProductsModel on ConnectedProducts {

  bool _showFavorites = false;

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  List<Product> get allProducts {
    return List.from(products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites) return List.from(products.where((Product p) => p.isFavorite).toList());
    return List.from(products);
  }

  Product get selectedProduct {
    if (selProductIndex == null) return null;
    return products[selProductIndex];
  }

  int get selectedProductIndex {
    return selProductIndex;
  }

   void updateProduct(String title, String description, double price, String image) {
    products[selProductIndex] = Product(title: title, description: description, image: image, price: price, userEmail: selectedProduct.userEmail, userId: selectedProduct.userId);
    selProductIndex = null;
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
      userEmail: selectedProduct.userEmail,
      userId: selectedProduct.userId,
      isFavorite: newFavoriteStatus
    );
    updateProduct(updatedProcut);
    notifyListeners();
    selProductIndex = null;
  }

  void deleteProduct() {  
    products.removeAt(selectedProductIndex);
    selProductIndex = null;
    notifyListeners();
  }

  void selectProduct(int index) {
    selProductIndex = index;
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}