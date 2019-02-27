import 'package:curso_udemy/scoped_models/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:curso_udemy/models/auth.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  AuthMode _authMode = AuthMode.Login;
  Color _color = Colors.white;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();
  final Map<String, dynamic> _formData = {
    'email': null,
    'password' : null,
    'acceptTerms' : false,
  };
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DecorationImage _buildImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.5), BlendMode.dstATop),
      image: AssetImage('assets/background.jpg')
    );
  }

  Widget _buildEmailInput() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        filled: true,
        fillColor: Colors.white,
        icon: Icon(Icons.email),
      ),
      onSaved: (String value) {
        _formData['email'] = value;
      },
      validator: (String value) {
        if (value.isEmpty) return "Email is required.";
        if (value.length <= 5) return "Email must have at least 5 characters";
        if (!value.contains('@') || !value.contains('.')) return "Email must be a valid email.";
        return null;
      },
    );
  }

  Widget _buildPasswordConfirmInput() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Confirm password',
        filled: true,
        fillColor: Colors.white,
        icon: Icon(Icons.lock),
      ),
      validator: (String value) {
        if (value != _passwordTextController.text) return 'The password and confirm password must match.';
        return null;
      },
    );
  }

  Widget _buildPasswordInput() {
    return TextFormField(
      controller: _passwordTextController,
      decoration: InputDecoration(
        labelText: 'Password',
        filled: true,
        fillColor: Colors.white,
        icon: Icon(Icons.lock)),
      autocorrect: false,
      obscureText: true,
      onSaved: (String value) {
        _formData['password'] = value;
      },
      validator: (String value) {
        if (value.isEmpty) return "Password is required.";
        if (value.length <= 5) return "Password must have at least 5 characters;";
        return null;
      },
    );
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      value: _formData['acceptTerms'],
      onChanged: (bool value) =>
        setState(() => _formData['acceptTerms'] = value),
      title: Text(
        'Accept Terms',
        style: TextStyle(color: _color),
      ),
    );
  }

  Widget _buildAuthModeSwitch() {
    return SwitchListTile(
      value: _authMode == AuthMode.Signup ? true : false,
      onChanged: (bool value) {
        setState(() {
          if (value == true) _authMode = AuthMode.Signup;
          else _authMode = AuthMode.Login;
        });
      },
      title: Text(
        'Signing Up?',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  void _sendForm(Function authenticationFunc) async {
    !_formData['acceptTerms'] ? setState(() => _color = Colors.red) : setState(() => _color = Colors.white);
    if (_formKey.currentState.validate() && _formData['acceptTerms']) {
      _formKey.currentState.save();
      final Map<String, dynamic> responseInfo = await authenticationFunc(_formData['email'], _formData['password'], _authMode);
      if (responseInfo['success']) Navigator.pushReplacementNamed(context, "/products");
      else _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(responseInfo['message'])));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 768.0 ? 500.0 : MediaQuery.of(context).size.width * 0.95;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Login'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            image: _buildImage(),
          ),
          child: Form(
            key: _formKey,
            child: Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Container(
                  width: targetWidth,
                  child: Column(
                    children: <Widget>[
                      _buildEmailInput(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _buildPasswordInput(),
                      SizedBox(height: 15,),
                      _authMode == AuthMode.Signup ? _buildPasswordConfirmInput() : Container(),
                      _buildAcceptSwitch(),
                      SizedBox(height: 15.0),
                      _buildAuthModeSwitch(),
                      SizedBox(height: 15.0),
                      ScopedModelDescendant<MainModel>(
                        builder: (BuildContext context, Widget child, MainModel model) {
                          if (model.isLoading) return Center(child: CircularProgressIndicator());
                          return RaisedButton(
                            child: Text(_authMode == AuthMode.Login ? 'Login' : 'Sign Up'),
                            textColor: Colors.white,
                            onPressed: () => _sendForm(model.authenticate),
                          );
                        }
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}