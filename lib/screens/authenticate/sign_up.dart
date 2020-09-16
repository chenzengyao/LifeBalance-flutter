import 'package:lifebalance/screens/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        toolbarHeight: 80.0,
        title: Text('Sign Up',
        style: TextStyle (
          color: Colors.black,
          fontSize: 30.0
        )),
        centerTitle: true,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In',
            style: TextStyle(
              color: Color(0XFFF2994A)
            )),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
                  filled: true,
                  fillColor: Color(0XFFF6F6F6),
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                  enabledBorder: OutlineInputBorder (
                      borderSide: BorderSide(color: Color(0xFFE8E8E8)),
                      borderRadius: BorderRadius.circular(7.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color:Colors.grey[400])
                  ),
                ),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);   //store input email to val
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
                  filled: true,
                  fillColor: Color(0XFFF6F6F6),
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                  enabledBorder: OutlineInputBorder (
                      borderSide: BorderSide(color: Color(0xFFE8E8E8)),
                      borderRadius: BorderRadius.circular(7.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color:Colors.grey[400])
                  ),
                ),                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);  //store input password to val
                },
              ),
              SizedBox(height: 35.0),
              Container(
                  width: 350.0,
                  height: 45.0,
                  child: RaisedButton(
                    color: Color(0xFF5E7A6C),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                          if(result == null) {
                            setState(() {
                              error = 'Please supply a valid email';
                            });
                          }
                        }
                      }
              ),
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}