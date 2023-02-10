import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gallery_app/common/colors.dart';
import 'package:gallery_app/common/component/custom_button.dart';
import 'package:gallery_app/common/component/custom_textfield.dart';
import 'package:gallery_app/common/constant.dart';
import 'package:gallery_app/common/dialog_controller.dart';
import 'package:gallery_app/common/extension.dart';

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
          context.loc.signUp,
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
                  controller: emailTextController, hintText: context.loc.email),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: passwordTextController,
                hintText: context.loc.password,
                isPassword: true,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                  controller: nameTextController, hintText: context.loc.name),
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
                            context: context,
                            title: context.loc.passwordIsTooWeak);
                      } else if (e.code == 'email-already-in-use') {
                        DialogController.showFailureDialog(
                            context: context,
                            title: context.loc.accountAlreadyExistForEmail);
                      } else if (e.code == "invalid-email") {
                        DialogController.showFailureDialog(
                            context: context, title: context.loc.invalidEmail);
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  textColor: CustomAppTheme.colorBlack,
                  buttonText: context.loc.signUp),
              SizedBox(
                height: PaddingConstants.padding20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
