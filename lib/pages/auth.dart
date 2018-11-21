import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AuthPageState();
  }

}
class _AuthPageState extends State<AuthPage> {

  String _email = "";
  String _password = "";
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Login'),
        ),
        body: Container(
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
              image: AssetImage('assets/background.jpg'),
            )
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
              children: <Widget>[
                TextField(
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
                ),
                SizedBox(height: 10.0,),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                    icon: Icon(Icons.lock)
                  ),
                  autocorrect: false,
                  obscureText: true,
                  onChanged: (String value) {
                    setState(() => _password = value);
                  },
                ),
                SwitchListTile(
                  value: _acceptTerms,
                  onChanged: (bool value) => setState(() => _acceptTerms = value),
                  title: Text('Accept Terms', style: TextStyle(color: Colors.white),),
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
          ),
        ),
      ),
    );
  }
}