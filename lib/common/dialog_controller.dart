import 'package:flutter/material.dart';
import 'package:gallery_app/common/extension.dart';
import 'colors.dart';
import 'component/custom_button.dart';
import 'constant.dart';

class DialogController {
  static void showNoConnectionDialog(
      {required BuildContext context, required VoidCallback onTryAgain}) {
    showDialog(
        context: context,
        builder: ((context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)), //this right here
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  ClipOval(
                    child: Material(
                      color: CustomAppTheme.colorForWarning, // Button color
                      child: InkWell(
                        child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(
                              Icons.info,
                              size: 32,
                              color: CustomAppTheme.colorWhite,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: PaddingConstants.med,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      context.loc.noConnectionPleaseTryAgain,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: FontSize.fontSize16,
                          fontWeight: FontWeight.w400,
                          color: CustomAppTheme.colorBlack.withOpacity(0.65)),
                    ),
                  ),
                  SizedBox(
                    height: PaddingConstants.med,
                  ),
                  CustomButton(
                      customHeight: 42,
                      customWidth: MediaQuery.of(context).size.width * 0.3,
                      backgroundColor: CustomAppTheme.colorBlack,
                      onPressed: (() {
                        onTryAgain();
                      }),
                      textColor: CustomAppTheme.colorWhite,
                      buttonText: context.loc.ok),
                  SizedBox(
                    height: PaddingConstants.large,
                  )
                ],
              ),
            ),
          );
        }));
  }

  static void showFailureDialog(
      {required BuildContext context,
      required String title,
      String? subTitle}) {
    showDialog(
        context: context,
        builder: ((context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)), //this right here
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: PaddingConstants.large,
                  ),
                  ClipOval(
                    child: Material(
                      color: CustomAppTheme.colorError, // Button color
                      child: InkWell(
                        child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(
                              Icons.close,
                              size: 32,
                              color: CustomAppTheme.colorWhite,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: PaddingConstants.med,
                  ),
                  Text(
                    title,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: FontSize.fontSize16,
                        fontWeight: FontWeight.w700,
                        color: CustomAppTheme.colorBlack),
                  ),
                  subTitle != null
                      ? Text(
                          subTitle,
                          style: TextStyle(
                              fontSize: FontSize.fontSize14,
                              color: CustomAppTheme.colorBlack),
                        )
                      : SizedBox.shrink(),
                  SizedBox(
                    height: PaddingConstants.med,
                  ),
                  CustomButton(
                      customWidth: MediaQuery.of(context).size.width * 0.6,
                      customHeight: 50,
                      backgroundColor: CustomAppTheme.colorBlack,
                      onPressed: (() {
                        Navigator.of(context).pop();
                      }),
                      textColor: CustomAppTheme.colorWhite,
                      buttonText: context.loc.ok),
                  SizedBox(
                    height: PaddingConstants.large,
                  )
                ],
              ),
            ),
          );
        }));
  }
}
