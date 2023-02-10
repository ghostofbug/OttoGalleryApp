import 'package:flutter/material.dart';

import '../colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  bool isPassword;
  CustomTextField(
      {required this.controller,
      required this.hintText,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: CustomAppTheme.colorWhite),
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle:
              TextStyle(color: CustomAppTheme.colorWhite.withOpacity(0.6)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: CustomAppTheme.colorWhite.withOpacity(1.0))),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: CustomAppTheme.colorWhite.withOpacity(0.5))),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: CustomAppTheme.colorWhite))),
    );
  }
}
