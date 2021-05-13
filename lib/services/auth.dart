import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_door/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_door/services/database.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final firestore = FirebaseFirestore.instance;

  // create user obj based on firebase user
  UserClass _userFromFirebaseUser(User user) {
    return user != null
        ? UserClass(
            uid: user.uid,
            displayName: user.displayName,
            email: user.email,
            photoURL: user.photoURL,
            phoneNumber: user.phoneNumber,
          )
        : null;
  }

  // auth change user stream --> realtime state
  Stream<UserClass> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future<void> updateProfile(
      String idToken, String displayName, String photoUrl) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:update?key=AIzaSyDjmefKhvEtDaiV7fb8qvqCq5MPTV4mD-o';

    try {
      final response = await http.post(url,
          body: json.encode({
            "idToken": idToken,
            "displayName": displayName ?? "",
            "photoUrl": photoUrl ?? "",
            "retuurnSecureToken": true,
          }));
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  // register email password
  Future registerWithEmailAndPassword(String email, String password,
      String displayName, String photoUrl) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //update profile
      var idToken = await _auth.currentUser.getIdToken();
      await updateProfile(idToken, displayName, photoUrl);
      User user = result.user;
      //setup database
      await DatabaseService(uid: user.uid)
          .updateUserData(user.uid, "master", displayName, user.email);
      await DatabaseService(uid: user.uid)
          .addMember(user.uid, displayName, user.email, "master");
      signOut();
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print(e.code);
      }
      return null;
    }
  }

  // sign in email password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = result.user;
      print(user);

      user.getIdTokenResult().then((value) => print(value.token));
      user.getIdToken().then((value) => print(value));
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print("Failed with error code: ${e.code}");
      print(e.message);
      return null;
    }
  }

  // Google SignIn
  Future signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      User user = authResult.user;
      bool have = false;
      await firestore.collection('home').get().then((value) {
        value.docs.forEach((element) {
          if (element.id == user.uid) {
            have = true;
          }
        });
        if (!have) {
          DatabaseService(uid: user.uid)
              .updateUserData(user.uid, "master", user.displayName, user.email);
          DatabaseService(uid: user.uid)
              .addMember(user.uid, user.displayName, user.email, "master");
        }
      });
      return _userFromFirebaseUser(user);
    } on FirebaseException catch (e) {
      print("Fail : ${e.code}");
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Sign out google
  Future signOutGoogle() async {
    try {
      return await googleSignIn.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Send password reset email
  Future sendPasswordResetEmail(String email) async {
    try {
      return _auth.sendPasswordResetEmail(email: email);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Update user information
  // Send email verification
  // Confirm email Verification
}
