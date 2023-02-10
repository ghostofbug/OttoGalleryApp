import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery_app/common/colors.dart';
import 'package:gallery_app/common/component/custom_button.dart';
import 'package:gallery_app/common/component/custom_textfield.dart';
import 'package:gallery_app/common/constant.dart';
import 'package:gallery_app/common/extension.dart';
import 'package:gallery_app/login/controller/login_controller.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  late LoginController loginController =
      LoginController(context: context, ref: ref);

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
                  controller: loginController.emailTextController,
                  hintText: context.loc.email),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: loginController.passwordTextController,
                hintText: context.loc.password,
                isPassword: true,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                  controller: loginController.nameTextController,
                  hintText: context.loc.name),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                  customWidth: MediaQuery.of(context).size.width,
                  customHeight: 50,
                  backgroundColor: CustomAppTheme.colorWhite,
                  onPressed: () {
                    loginController.signUp();
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
