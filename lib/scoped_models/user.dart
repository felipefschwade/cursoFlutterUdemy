import 'package:curso_udemy/models/user.dart';
import 'package:curso_udemy/scoped_models/connected_products.dart';
import 'package:scoped_model/scoped_model.dart';

mixin UserModel on ConnectedProducts {
  void login(String email, String password)
  {
    authUser = User(id: 'asdasdasd', email: email, password: password);
  }
}