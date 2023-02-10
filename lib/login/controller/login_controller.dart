import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery_app/common/extension.dart';
import 'package:gallery_app/provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../common/dialog_controller.dart';

class LoginController {
  final BuildContext context;

  final WidgetRef ref;
  LoginController({required this.context, required this.ref});

  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();

  void signUp() async {
    EasyLoading.show();
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
      await FirebaseAuth.instance.currentUser
          ?.updateDisplayName(nameTextController.text);
      EasyLoading.dismiss();
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      if (e.code == 'weak-password') {
        DialogController.showFailureDialog(
            context: context, title: context.loc.passwordIsTooWeak);
      } else if (e.code == 'email-already-in-use') {
        DialogController.showFailureDialog(
            context: context, title: context.loc.accountAlreadyExistForEmail);
      } else if (e.code == "invalid-email") {
        DialogController.showFailureDialog(
            context: context, title: context.loc.invalidEmail);
      }
    } catch (e) {
      print(e);
    }
  }

  void onAuthStatusChange() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        ref.read(isLoggedInProvider.notifier).state = true;
      } else {
        ref.read(isLoggedInProvider.notifier).state = false;
        emailTextController = TextEditingController();
        passwordTextController = TextEditingController();
      }
    });
  }

  void signIn() async {
    EasyLoading.show();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);
      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      DialogController.showFailureDialog(context: context, title: e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      EasyLoading.show();
      var result = await GoogleSignIn(scopes: ['email', 'profile']).signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await result?.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      EasyLoading.dismiss();
    } catch (error) {
      EasyLoading.dismiss();
      DialogController.showFailureDialog(
          context: context, title: error.toString());
    }
  }
}
