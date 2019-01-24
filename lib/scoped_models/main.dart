import 'package:scoped_model/scoped_model.dart';
import 'package:curso_udemy/scoped_models/products.dart';
import 'package:curso_udemy/scoped_models/user.dart';
import 'package:curso_udemy/scoped_models/connected_products.dart';

class MainModel extends Model with ConnectedProducts, ProductsModel, UserModel {}