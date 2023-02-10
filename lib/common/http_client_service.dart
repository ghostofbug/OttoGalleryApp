import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gallery_app/common/extension.dart';

import '../main.dart';
import 'dialog_controller.dart';
import 'environment.dart';
import 'logger.dart';

enum HttpMethod { POST, GET }

class HttpClientService {
  var dio = Dio();
  static bool isHasInternetConnection = true;

  Future<void> requestTo(
      {required String url,
      required HttpMethod method,
      required Map<String, dynamic> parameters,
      required void Function()? Function(dynamic result) success,
      required void Function()? Function(dynamic error) failure,
      bool isDisplayLoading = true}) async {
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Client-ID ${Environment.clientId}";
    dio.options.connectTimeout = 6000;
    url = Environment.apiUrl + url;
    if (isDisplayLoading) {
      if (EasyLoading.isShow == false) {
        EasyLoading.show(maskType: EasyLoadingMaskType.black);
      }
    }
    switch (method) {
      case HttpMethod.POST:
        {
          try {
            var response = await dio.post(url, data: parameters);
            isDisplayLoading ? EasyLoading.dismiss() : 1;
            if (response.statusCode == 200 || response.statusCode == 201) {
              AppLogger.resultApiLog("Success", response.data.toString(), url,
                  method.name.toString(), parameters.toString());
              success(response.data);
            } else {
              AppLogger.failureApiLog("Failure", response.data.toString(), url,
                  method.name.toString(), parameters.toString());
              failure(response.data);
            }
            break;
          } on DioError catch (ex) {
            isDisplayLoading ? EasyLoading.dismiss() : 1;
            if (ex.type == DioErrorType.connectTimeout) {
              AppLogger.failureApiLog("Failure", "Time Out", url,
                  method.name.toString(), parameters.toString());
              isDisplayLoading ? EasyLoading.dismiss() : 1;
              var error = Map<String, dynamic>();
              AppLogger.failureApiLog("Failure", error.toString(), url,
                  method.name.toString(), parameters.toString());
              failure(error);
              DialogController.showFailureDialog(
                  context: navigatorKey.currentContext!,
                  title: navigatorKey.currentContext!.loc.connectionTimeOutPleaseTryAgainLater);
              return;
            }

            if (ex.response != null) {
              AppLogger.failureApiLog("Failure", ex.response!.data.toString(),
                  url, method.name, parameters.toString());
              failure(ex.response?.data);
              DialogController.showFailureDialog(
                  context: navigatorKey.currentContext!,
                  title: ex.response!.data.toString());
            } else {
              AppLogger.failureApiLog(
                  "Failure", "", url, method.name, parameters.toString());
              failure(ex.response?.data);
              DialogController.showFailureDialog(
                  context: navigatorKey.currentContext!,
                  title: navigatorKey.currentContext!.loc
                      .somethingErrorHappenPleaseTryAgainLater);
            }
          }
          break;
        }
      case HttpMethod.GET:
        try {
          var response = await dio.get(url, queryParameters: parameters);
          isDisplayLoading ? EasyLoading.dismiss() : 1;
          if (response.statusCode == 200 || response.statusCode == 201) {
            AppLogger.resultApiLog(
                "Success",
                response.data.toString(),
                response.realUri.toString(),
                method.name.toString(),
                parameters.toString());
            success(response.data);
          } else {
            AppLogger.failureApiLog("Failure", response.data.toString(), url,
                method.name, parameters.toString());
            failure(response.data);
          }
          break;
        } on DioError catch (ex) {
          isDisplayLoading ? EasyLoading.dismiss() : 1;
          if (ex.type == DioErrorType.connectTimeout) {
            var error = new Map<String, dynamic>();
            AppLogger.failureApiLog(
                "Failure", "Time Out", url, method.name, parameters.toString());
            isDisplayLoading ? EasyLoading.dismiss() : 1;
            failure(error);
            DialogController.showFailureDialog(
                context: navigatorKey.currentContext!,
                title: navigatorKey
                    .currentContext!.loc.connectionTimeOutPleaseTryAgainLater);
            return;
          }
          if (ex.response != null) {
            AppLogger.failureApiLog("Failure", ex.response!.data.toString(),
                url, method.name, parameters.toString());
            failure(ex.response?.data);
            DialogController.showFailureDialog(
                context: navigatorKey.currentContext!,
                title: ex.response!.data.toString());
          } else {
            AppLogger.failureApiLog(
                "Failure", "", url, method.name, parameters.toString());
            failure(ex.response?.data);
            DialogController.showFailureDialog(
                context: navigatorKey.currentContext!,
                title: navigatorKey.currentContext!.loc
                    .somethingErrorHappenPleaseTryAgainLater);
          }
        }
        break;
    }
  }
}
