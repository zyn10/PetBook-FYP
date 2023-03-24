import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petbook/model/user.dart' as model;
import 'package:petbook/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

//sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String fullname,
    required Uint8List file,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          fullname.isNotEmpty ||
          file != null) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);
        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          email: email,
          fullname: fullname,
          followers: [],
          following: [],
        );
        await _firestore.collection("users").doc(cred.user!.uid).set(
              user.toJson(),
            );
        res = 'success';
      } else {
        res = "Please enter all the fields";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = "invalid email";
      } else if (err.code == 'email-already-in-use') {
        res = "Account Already exists";
      } else if (err.code == 'weak-password') {
        res = "Password Provided is too Weak";
      } else {
        res = "Something Went Wrong!";
      }
    }
    return res;
  }

  //logging in user

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = 'Some Error Occured';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = "Please enter all the fields";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'wrong-email') {
        res = "Wrong Credentials";
      }
    }
    return res;
  }
}
