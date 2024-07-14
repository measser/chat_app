import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xff2B475E);
const kLogo = 'assets/images/scholar.png';
const kMessages = 'messages';
const kShow = 'message';

void showSnackBar(BuildContext context,String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar
    (content: Text(message) ));
}

Future<UserCredential> registerUser(String email,String password) async {
  UserCredential user =await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email, password: password);
  return user;
}
Future<UserCredential> signIn(String email,String password) async {
  UserCredential user =await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email, password: password);
  return user;
}