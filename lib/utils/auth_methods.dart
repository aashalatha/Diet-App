import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stayfit/ui/homepage.dart';
import 'package:stayfit/login_page.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //signup
  Future<String> signupUser(
      {required String email,
      required String password,
      required String name}) async {
    String result = "some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        //register
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

            await _firebaseFirestore.collection('users').doc(credential.user!.uid).set({
              'name':name,
              'uid':credential.user!.uid,
              'email':email,
            });

        result = "success";
        log(result);
      }
    } catch (err) {
      result = err.toString();
      log(result);
    }
    return result;
  }
 
  //login user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
