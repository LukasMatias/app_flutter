import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser firabaseUser;
  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  Future<void> signIn(
      {@required String email,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

   await _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) {
          firabaseUser = user as FirebaseUser;

          onSuccess();
          isLoading = false;
          notifyListeners();
    })
        .catchError((e) {
          onFail();
          isLoading = false;
          notifyListeners();
   });
  }

  void signUp(
      {@required Map<String, dynamic> userData,
      @required String pass,
      @required VoidCallback onSucess,
      @required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();

    _auth
        .createUserWithEmailAndPassword(
            email: userData["email"], password: pass)
        .then((user) async {
      firabaseUser = user as FirebaseUser;

      onSucess();
      isLoading = false;

      await _saveUserData(userData);

      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void recoverPass() {}

  bool isLoadingIn() {
    return firabaseUser != null;
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance
        .collection("user")
        .document(firabaseUser.uid)
        .setData(userData);
  }

  void signOut() async {
    await _auth.signOut();

    userData = Map();
    firabaseUser = null;

    notifyListeners();
  }
}
