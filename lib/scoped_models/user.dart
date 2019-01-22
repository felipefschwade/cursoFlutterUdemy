import 'package:curso_udemy/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

mixin UserModel on Model {
  User _authUser;

  void login(String email, String password)
  {
    _authUser = User(id: 'asdasdasd', email: email, password: password);
  }
}