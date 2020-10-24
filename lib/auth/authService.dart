import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifebalance/Objects/user.dart';
import 'package:lifebalance/auth/signIn.dart';
import 'package:lifebalance/screens/Dashboard.dart';

User currentUser;
DocumentReference currentUserDocumentReference;

class AuthService {
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.hasData) {
          return StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection('/users')
                  .document(snapshot.data.uid)
                  .snapshots(),
              builder: (context, docsnapshot) {
                if (docsnapshot.hasData) {
                  if (docsnapshot.data.exists) {
                    currentUser = User.fromJson(docsnapshot.data.data);
                    currentUserDocumentReference = Firestore.instance
                        .collection('/users')
                        .document(currentUser.uid);
                    return Dashboard();
                  } else {
                    currentUser = null;// just fix the ui overflows by yourself
                    return Scaffold(
                      body: Container(
                        child: Center(
                            child: InkWell(
                              onTap: (){
                                FirebaseAuth.instance.signOut();
                              },
                              child: Text(
                                  "There was an error, Please restart the app."),
                            )),
                      ),
                    );
                  }
                } else {
                  currentUser = null;
                  return Container(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              });
        } else {
          return SignIn();
        }
      },
    );
  }
}
