import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery_app/common/colors.dart';
import 'package:gallery_app/common/component/custom_button.dart';
import 'package:gallery_app/common/component/custom_textfield.dart';
import 'package:gallery_app/common/constant.dart';
import 'package:gallery_app/common/extension.dart';
import 'package:gallery_app/login/controller/login_controller.dart';
import 'package:gallery_app/provider/provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  

  late LoginController loginController =
      LoginController(context: context, ref: ref);
      

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginController.onAuthStatusChange();
  }

  @override
  Widget build(BuildContext context) {
    var isLoginIn = ref.watch(isLoggedInProvider);
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
                  controller: loginController.emailTextController,
                  hintText: context.loc.email),
              SizedBox(
                height: PaddingConstants.padding20,
              ),
              CustomTextField(
                controller: loginController.passwordTextController,
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
                  onPressed: () async {},
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
                    await loginController.signInWithGoogle();
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
