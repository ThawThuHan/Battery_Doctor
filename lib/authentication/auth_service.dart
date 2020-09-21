import 'package:batterydoctor/pages/loginpages/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:batterydoctor/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  registerWithEmail(email, password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  signInWithEmail(email, password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser user = result.user;
      return user.email;
    } catch (e) {
      print(e);
      return null;
    }
  }

  logout() {
    _auth.signOut();
  }

  handleAuth() {
    return StreamBuilder(
      stream: _auth.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          FirebaseUser user = snapshot.data;
          String uid = user.uid;
          return Home();
        } else {
          return SignIn();
        }
      },
    );
  }
}
