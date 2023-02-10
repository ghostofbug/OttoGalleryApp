import 'dart:async';

import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class AppLogger {
  static final logger = Logger(
      output: CustomLogOutput(),
      printer: PrettyPrinter(
        printTime: true,
        printEmojis: true,
        methodCount: 5,
      ));

  static void failureApiLog(String status, String result, String apiUrl,
      String method, String parameter) {
    String loggedString = """
        ❌❌❌status:  ${status}
        api_url: ${apiUrl}
        method : ${method}
        body   : ${parameter.toString()}
        result:  ${result}
    """;
    logger.e(loggedString);
  }

  static void resultApiLog(String status, String result, String apiUrl,
      String method, String parameter) {
    String loggedString = """
        ✅✅✅ status:  ${status}
        api_url : ${apiUrl}
        method : ${method}
        body   : ${parameter.toString()}
        result:  ${result}
    """;
    logger.v(
      loggedString,
    );
  }

  static void buttonActionLog(String buttonName, String screenName) {
    String loggedString = """👋👋👋
      Screen: ${screenName}   Button ${buttonName} clicked
  """;
    logger.v(loggedString);
  }
}

class CustomLogOutput extends LogOutput {
  CustomLogOutput();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  // Future<File> get _logfile async {
  //   final path = await _localPath;
  //   var dateTimeNow = DateTime.now();
  //   var fileName = DateFormat("yyyy-MM-dd").format(dateTimeNow);
  //   return File('$path/${fileName}.txt');
  // }

  // Future<void> deleteFile() async {
  //   try {
  //     final file = await _logfile;

  //     await file.delete();
  //   } catch (e) {}
  // }

  @override
  void output(OutputEvent event) async {
    for (var line in event.lines) {
      print(line);
      //final file = await _logfile;
      //line = line.replaceAll("[0m", "");
      //file.writeAsStringSync(line + "\n", mode: FileMode.writeOnlyAppend);
    }
  }
}
