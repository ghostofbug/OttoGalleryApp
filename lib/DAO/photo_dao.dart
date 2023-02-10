import 'package:floor/floor.dart';
import 'package:gallery_app/model/photo_model/photo_model.dart';

import '../common/storage_controller.dart';

@dao
abstract class PhotoDao {
  @delete
  Future<void> deleteFavouritePhoto(Photo photo);

  final database = StorageController.database!.database;

  Future<bool> checkExistFavoritePhoto(String id) async {
    var sql = """ SELECT * FROM FAVOURITE_PHOTO FP WHERE FP.id = '$id'
       """;
    List<Map> result = await database.rawQuery(sql);
    return result.isNotEmpty;
  }

  Future<List<Photo>> getFavouritePhotos(int page,
      {int itemPerPage = 5}) async {
    List<Photo> favouritePhoto = [];
    var sql =
        """ SELECT * FROM FAVOURITE_PHOTO FP, FAVOURITE_IMAGE_URLS FIU WHERE FP.id = FIU.id ORDER BY FP.favouriteAddDate DESC
        LIMIT $itemPerPage OFFSET ${(page - 1) * itemPerPage}
       """;
    List<Map> result = await database.rawQuery(sql);
    for (var element in result) {
      var photo = Photo.fromJson(element as Map<String, dynamic>);
      photo.imageUrls = ImageUrl.ImageUrlFromJson(element);
      favouritePhoto.add(photo);
    }
    return favouritePhoto;
  }

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFavouritePhoto(Photo photo);
}
