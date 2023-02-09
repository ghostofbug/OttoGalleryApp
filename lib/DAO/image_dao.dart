

import 'package:floor/floor.dart';
import 'package:gallery_app/model/image_dataset/image_dataset.dart';

import '../common/storage_controller.dart';

@dao
abstract class ImageDao {
  @Query('SELECT * FROM FAVOURITE_IMAGE')
  Future<List<ImageDataset>> getAllFavouriteImage();

  @delete
  Future<void> deleteFavouriteImage(ImageDataset image);

  final database = StorageController.database!.database;

  Future<bool> checkExistFavoriteImage(String id) async {
    var sql = """ SELECT * FROM FAVOURITE_IMAGE FI WHERE FI.id = '$id'
       """;
    List<Map> result = await database.rawQuery(sql);
    return result.isNotEmpty;
  }

  Future<List<ImageDataset>> getFavouriteImages(int page,
      {int itemPerPage = 5}) async {
    List<ImageDataset> favouriteImages = [];
    var sql =
        """ SELECT * FROM FAVOURITE_IMAGE FI, FAVOURITE_IMAGE_URLS FIU WHERE FI.id = FIU.id ORDER BY FI.favouriteAddDate
        LIMIT $itemPerPage OFFSET ${(page - 1) * itemPerPage}
       """;
    List<Map> result = await database.rawQuery(sql);
    for (var element in result) {
      var image = ImageDataset.fromJson(element as Map<String, dynamic>);
      image.imageUrls = ImageUrl.ImageUrlFromJson(element);
      favouriteImages.add(image);
    }
    return favouriteImages;
  }

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFavouriteImage(ImageDataset imageDataset);
}
