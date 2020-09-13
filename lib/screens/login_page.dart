import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lifebalance/screens/profile_page2.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children:<Widget>[
            //TODO: Implement Login Page (Design)
            TextFormField(
              validator: (input) {
                if(input.isEmpty) {
                  return 'Please enter an email';
                }
              },
              onSaved: (input) => _email = input,
              decoration: InputDecoration(
                labelText: 'Email'
              ),
            ),
            TextFormField(
              validator: (input) {
                if(input.length < 6) {
                  return 'Your password needs at least 6 characters';
                }
              },
              onSaved: (input) => _password = input,
              decoration: InputDecoration(
                  labelText: 'Password'
              ),
              obscureText: true,
            ),
            RaisedButton(
              onPressed: signIn,
              child: Text('Sign in')
            ),


            FlatButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/Calendar');
              },
              icon: Icon(Icons.arrow_right),
              label: Text('See next screen'),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        UserCredential user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context) => profile_page2(user: user)));
      } catch (e) {
        print(e.message);
      }
    }
  }
}

