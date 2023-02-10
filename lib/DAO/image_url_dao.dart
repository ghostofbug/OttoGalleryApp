import 'package:floor/floor.dart';


import '../model/photo_model/photo_model.dart';

@dao
abstract class ImageUrlDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFavouriteImageUrl(ImageUrl imageUrl);
}
 