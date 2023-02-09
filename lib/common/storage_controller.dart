

import '../database/database.dart';

class StorageController {
  

  

  static AppDatabase? database;
  //neeed to call first
  static Future<void> buildDatabase() async {
    database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }


}
