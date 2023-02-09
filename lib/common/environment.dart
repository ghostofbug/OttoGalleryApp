import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static const env = String.fromEnvironment("ENV", defaultValue: "uat");
  static String get fileName => env == "uat" ? "uat.env" : "prod.env";
  static String get apiUrl => dotenv.env['API_URL'] ?? "";
  static String get clientId => dotenv.env["CLIENT_ID"] ?? "";
}
