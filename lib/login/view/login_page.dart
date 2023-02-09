import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gallery_app/common/colors.dart';
import 'package:gallery_app/common/component/custom_button.dart';
import 'package:gallery_app/common/constant.dart';
import 'package:gallery_app/common/dialog_controller.dart';
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
                "Email",
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
          "Login",
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
              TextFormField(
                style: TextStyle(color: CustomAppTheme.colorWhite),
                controller: emailController,
                decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(
                        color: CustomAppTheme.colorWhite.withOpacity(0.6)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: CustomAppTheme.colorWhite.withOpacity(1.0))),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: CustomAppTheme.colorWhite.withOpacity(0.5))),
                    border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: CustomAppTheme.colorWhite))),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                style: TextStyle(color: CustomAppTheme.colorWhite),
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(
                        color: CustomAppTheme.colorWhite.withOpacity(0.6)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: CustomAppTheme.colorWhite.withOpacity(1.0))),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: CustomAppTheme.colorWhite.withOpacity(0.5))),
                    border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: CustomAppTheme.colorWhite))),
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                  customWidth: MediaQuery.of(context).size.width,
                  customHeight: 50,
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
                  buttonText: "Login"),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      await GoogleSignIn().signIn();
                    } catch (error) {
                      DialogController.showFailureDialog(
                          context: context, title: error.toString());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    primary: Colors.white,
                    elevation: 2,
                    padding: const EdgeInsets.all(10),
                  ),
                  icon: Image.asset(
                    "assets/google_button.png",
                    width: 24,
                    height: 24,
                  ),
                  label: Text(
                    "Login with Google",
                    style: TextStyle(color: CustomAppTheme.colorBlack),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteSetting.signUp);
                  },
                  child: Text(
                    "Dont have account? Sign up",
                    style: TextStyle(color: CustomAppTheme.colorWhite),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
