import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../colors.dart';
import '../constant.dart';
import '../logger.dart';

class CustomButton extends StatefulWidget {
  CustomButton(
      {Key? key,
      required this.backgroundColor,
      required this.onPressed,
      required this.textColor,
      required this.buttonText,
      this.customHeight,
      this.customWidth,
      this.borderRadius,
      this.borderColor})
      : super(key: key);

  final Color backgroundColor;
  final String buttonText;
  final Color textColor;
  final VoidCallback? onPressed;
  final double? customHeight;
  final double? customWidth;
  final Color? borderColor;
  final double? borderRadius;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.customWidth,
      height: widget.customHeight,
      child: ElevatedButton(
          child: Text(widget.buttonText,
              style: TextStyle(
                  fontSize: FontSize.fontSize16,
                  color: widget.textColor,
                  fontWeight: FontWeight.w700)),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  return widget.backgroundColor; // Use the component's default.
                },
              ),
              animationDuration: Duration(),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: widget.borderRadius != null
                          ? BorderRadius.circular(widget.borderRadius!)
                          : BorderRadius.circular(8),
                      side: BorderSide(
                          width: widget.borderColor != null ? 2 : 0,
                          style: widget.borderColor != null
                              ? BorderStyle.solid
                              : BorderStyle.none,
                          color: widget.borderColor ?? Colors.transparent)))),
          onPressed: widget.onPressed != null
              ? () {
                  // AppLogger.buttonActionLog(
                  //     widget.buttonText, ModalRoute.of(context)?.settings.name ?? "");

                  widget.onPressed!();
                }
              : null),
    );
  }
}
