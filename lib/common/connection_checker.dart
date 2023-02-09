import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gallery_app/common/dialog_controller.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../main.dart';

mixin ConnectionChecker {
  late StreamSubscription<InternetConnectionStatus> connectionListener;
  void cancelConnectionChecker() {
    connectionListener.cancel();
  }

  _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  void setUpConnectionChecker({VoidCallback? onTryAgain}) {
    //InternetConnectionChecker().checkInterval = Duration(seconds: 1);
    connectionListener =
        InternetConnectionChecker().onStatusChange.listen((status) async {
      switch (status) {
        case InternetConnectionStatus.connected:
          break;
        case InternetConnectionStatus.disconnected:
          if (_isThereCurrentDialogShowing(navigatorKey.currentContext!)) {
            return;
          }
          DialogController.showNoConnectionDialog(
            context: navigatorKey.currentContext!,
            onTryAgain: () async {
              var isDeviceConnected =
                  await InternetConnectionChecker().hasConnection;
              if (isDeviceConnected == true) {
                Navigator.of(navigatorKey.currentContext!).pop();
                if (onTryAgain != null) {
                  onTryAgain();
                }
              }
            },
          );
          break;
      }
    });
  }
}
