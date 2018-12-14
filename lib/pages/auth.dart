import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  Color _color = Colors.white;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'email': null,
    'password' : null,
    'acceptTerms' : false,
  };

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

  Widget _buildPasswordInput() {
    return TextFormField(
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

  void _sendForm() {
    if (!_formData['acceptTerms']) setState(() => _color = Colors.red);
    if (_formKey.currentState.validate() && _formData['acceptTerms']) {
      _formKey.currentState.save();
      Navigator.pushReplacementNamed(context, "/products");
    }
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
                      _buildAcceptSwitch(),
                      SizedBox(height: 15.0),
                      RaisedButton(
                        child: Text('Login'),
                        textColor: Colors.white,
                        onPressed: _sendForm,
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