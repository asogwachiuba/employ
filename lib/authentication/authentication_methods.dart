import 'package:employ/constants/custom_colors.dart';
import 'package:employ/utilities/show_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

//user google sign in method
Future<bool> signInByGoogle() async {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final googleUser = await _googleSignIn.signIn();
  if (googleUser == null) return false;
  final googleAuth = await googleUser.authentication;

  final credentials = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

  await FirebaseAuth.instance.signInWithCredential(credentials);
  print(FirebaseAuth.instance.currentUser?.uid);
  print(FirebaseAuth.instance.currentUser?.email);
  print(FirebaseAuth.instance.currentUser?.phoneNumber);
  print(FirebaseAuth.instance.currentUser?.tenantId);
  return true;
}

// user sign in method
Future<bool> signIn(String email, String password, BuildContext context) async {
  try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch(e) {
    if (kDebugMode) {
      //showSnackBar(e.toString(), context, const Duration(milliseconds: 800), CColor.red);
    }
    return false;
  }
}

// user sign up method
Future<bool> signUp(String email, String password, BuildContext context) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    //final user = FirebaseAuth.instance.currentUser;
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      showSnackBar('The password provided is too weak.', context, const Duration(milliseconds: 800), CColor.red);
    } else if (e.code == 'email-already-in-use') {
      showSnackBar('The account already exists for that email', context, const Duration(milliseconds: 800), CColor.red);
    }
    return false;
  }
   catch (e) {
    showSnackBar(e.toString(), context, const Duration(milliseconds: 800), CColor.red);
    return false;
  }
}
