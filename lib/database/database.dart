// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:gallery_app/DAO/image_dao.dart';
import 'package:gallery_app/DAO/image_url_dao.dart';
import 'package:gallery_app/model/image_dataset/image_dataset.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [ImageDataset, ImageUrl])
abstract class AppDatabase extends FloorDatabase {
  ImageDao get imageDao;
  ImageUrlDao get imageUrlDao;
}
