import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AuthPageState();
  }

}
class _AuthPageState extends State<AuthPage> {

  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Login'),
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ListView(
              children: <Widget>[
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    icon: Icon(Icons.email)
                  ),
                  onChanged: (String value) {
                    setState(() => email = value);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    icon: Icon(Icons.lock)
                  ),
                  autocorrect: false,
                  obscureText: true,
                  onChanged: (String value) {
                    setState(() => password = value);
                  },
                ),
                SizedBox(height: 15.0),
                RaisedButton(
                  child: Text('Login'),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/products");
                  },
                ),
              ],
            ),
          )
        ),
    );
  }
}