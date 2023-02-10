// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:gallery_app/DAO/photo_dao.dart';
import 'package:gallery_app/DAO/image_url_dao.dart';
import 'package:gallery_app/model/photo_model/photo_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Photo, ImageUrl])
abstract class AppDatabase extends FloorDatabase {
  PhotoDao get imageDao;
  ImageUrlDao get imageUrlDao;
}
