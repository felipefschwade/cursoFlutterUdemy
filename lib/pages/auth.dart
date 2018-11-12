import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Login'),
        ),
        body: Center(
          child: RaisedButton(
            child: Text('Login'),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/products");
            },
          ),
        ),
    );
  }

}