import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifebalance/screens/login_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
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
                onPressed: signUp,
                child: Text('Sign up')
            )
          ],
        ),
      ),
    );
  }
  void signUp() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);  //Create new user

        // User user = FirebaseAuth.instance.currentUser;
        // if (!user.emailVerified){
        //   await user.sendEmailVerification();
        // }

        Navigator.of(context).pop();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password'){
          print('The password provided is too weak');

        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
