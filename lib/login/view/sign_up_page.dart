import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gallery_app/common/colors.dart';
import 'package:gallery_app/common/component/custom_button.dart';
import 'package:gallery_app/common/constant.dart';
import 'package:gallery_app/common/dialog_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomAppTheme.colorBlack,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: CustomAppTheme.colorBlack,
        title: Text(
          "Sign Up",
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
                controller: emailTextController,
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
                controller: passwordTextController,
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
              TextFormField(
                style: TextStyle(color: CustomAppTheme.colorWhite),
                controller: nameTextController,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Name",
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
                height: 30,
              ),
              CustomButton(
                  customWidth: MediaQuery.of(context).size.width,
                  customHeight: 50,
                  backgroundColor: CustomAppTheme.colorWhite,
                  onPressed: () async {
                    EasyLoading.show();
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
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
                            context: context, title: "Password is too weak");
                      } else if (e.code == 'email-already-in-use') {
                        DialogController.showFailureDialog(
                            context: context,
                            title:
                                "The account already exists for that email.");
                      } else if (e.code == "invalid-email") {
                        DialogController.showFailureDialog(
                            context: context, title: "Invalid email");
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  textColor: CustomAppTheme.colorBlack,
                  buttonText: "Sign Up"),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
