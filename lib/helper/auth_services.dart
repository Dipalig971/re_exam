import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{
  static AuthServices authServices = AuthServices._();
  AuthServices._();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> createAccount(String email, String password) async {
    try{
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      print(userCredential.user!.email);
      return  'Success';
    } catch(e)
    {
      log(e.toString());
      return 'failed';
    }
  }
}