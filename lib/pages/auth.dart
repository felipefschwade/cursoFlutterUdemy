import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String _email = "";
  String _password = "";
  bool _acceptTerms = false;

  DecorationImage _buildImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.5), BlendMode.dstATop),
      image: AssetImage('assets/background.jpg')
    );
  }

  Widget _buildEmailInput() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        filled: true,
        fillColor: Colors.white,
        icon: Icon(Icons.email),
      ),
      onChanged: (String value) {
        setState(() => _email = value);
      },
    );
  }

  Widget _buildPasswordInput() {
    return TextField(
      decoration: InputDecoration(
          labelText: 'Password',
          filled: true,
          fillColor: Colors.white,
          icon: Icon(Icons.lock)),
      autocorrect: false,
      obscureText: true,
      onChanged: (String value) {
        setState(() => _password = value);
      },
    );
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      value: _acceptTerms,
      onChanged: (bool value) =>
          setState(() => _acceptTerms = value),
      title: Text(
        'Accept Terms',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 768.0 ? 500.0 : MediaQuery.of(context).size.width * 0.95;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          image: _buildImage(),
        ),
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
                  _buildAcceptSwitch(),
                  SizedBox(height: 15.0),
                  RaisedButton(
                    child: Text('Login'),
                    textColor: Colors.white,
                    onPressed: () => Navigator.pushReplacementNamed(context, "/products"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}