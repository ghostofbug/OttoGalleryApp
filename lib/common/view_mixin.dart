import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

mixin CustomView {
  late StreamSubscription<InternetConnectionStatus> listener;

  void setUpLostConnection(BuildContext context, VoidCallback onTryAgain) {
    listener = InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          print('Data connection is available.');
          break;
        case InternetConnectionStatus.disconnected:
          print('You are disconnected from the internet.');

          break;
      }
    });
  }

  void cancelLostConnectionListener() {
    listener.cancel();
  }
}
