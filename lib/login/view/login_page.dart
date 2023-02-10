import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gallery_app/common/colors.dart';
import 'package:gallery_app/common/component/custom_button.dart';
import 'package:gallery_app/common/component/custom_textfield.dart';
import 'package:gallery_app/common/constant.dart';
import 'package:gallery_app/common/dialog_controller.dart';
import 'package:gallery_app/common/extension.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var isLoginIn = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          isLoginIn = true;
        });
      } else {
        emailController = TextEditingController();
        passwordController = TextEditingController();
        setState(() {
          isLoginIn = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoginIn) {
      return Scaffold(
        backgroundColor: CustomAppTheme.colorBlack,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: CustomAppTheme.colorBlack,
          actions: [
            IconButton(
                onPressed: () async {
                  EasyLoading.show();
                  await FirebaseAuth.instance.signOut();
                  EasyLoading.dismiss();
                },
                icon: Icon(Icons.logout))
          ],
          title: Text(
            FirebaseAuth.instance.currentUser?.displayName ?? "",
            style: TextStyle(
                fontSize: FontSize.fontSize22,
                color: CustomAppTheme.colorWhite,
                fontWeight: FontWeight.w700),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.loc.email,
                style: TextStyle(color: CustomAppTheme.colorWhite),
              ),
              Text(
                FirebaseAuth.instance.currentUser?.email ?? "",
                style: TextStyle(color: CustomAppTheme.colorWhite),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: CustomAppTheme.colorBlack,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: CustomAppTheme.colorBlack,
        title: Text(
          context.loc.login,
          style: TextStyle(
              fontSize: FontSize.fontSize22,
              color: CustomAppTheme.colorWhite,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              CustomTextField(
                  controller: emailController, hintText: context.loc.email),
              SizedBox(
                height: PaddingConstants.padding20,
              ),
              CustomTextField(
                controller: passwordController,
                hintText: context.loc.password,
                isPassword: true,
              ),
              SizedBox(
                height: PaddingConstants.padding20,
              ),
              CustomButton(
                  customWidth: MediaQuery.of(context).size.width,
                  customHeight: ComponentSize.buttonHeight,
                  backgroundColor: CustomAppTheme.colorWhite,
                  onPressed: () async {
                    EasyLoading.show();
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text);
                      EasyLoading.dismiss();
                    } on FirebaseAuthException catch (e) {
                      EasyLoading.dismiss();
                      DialogController.showFailureDialog(
                          context: context, title: e.toString());
                    }
                  },
                  textColor: CustomAppTheme.colorBlack,
                  buttonText: context.loc.login),
              SizedBox(
                height: PaddingConstants.padding20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: ComponentSize.buttonHeight,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      EasyLoading.show();
                      var result =
                          await GoogleSignIn(scopes: ['email', 'profile'])
                              .signIn();
                      // Obtain the auth details from the request
                      final GoogleSignInAuthentication? googleAuth =
                          await result?.authentication;
                      // Create a new credential
                      final credential = GoogleAuthProvider.credential(
                        accessToken: googleAuth?.accessToken,
                        idToken: googleAuth?.idToken,
                      );
                      // Once signed in, return the UserCredential
                      await FirebaseAuth.instance
                          .signInWithCredential(credential);
                      EasyLoading.dismiss();
                    } catch (error) {
                      EasyLoading.dismiss();
                      DialogController.showFailureDialog(
                          context: context, title: error.toString());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: CustomAppTheme.colorWhite,
                    elevation: 2,
                    padding: const EdgeInsets.all(10),
                  ),
                  icon: Image.asset(
                    "assets/google_button.png",
                    width: 24,
                    height: 24,
                  ),
                  label: Text(
                    context.loc.loginWithGoogle,
                    style: TextStyle(
                        color: CustomAppTheme.colorBlack,
                        fontSize: FontSize.fontSize16,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(
                height: PaddingConstants.padding20,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteSetting.signUp);
                  },
                  child: Text(
                    context.loc.dontHaveAccountSignUp,
                    style: TextStyle(color: CustomAppTheme.colorWhite),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
