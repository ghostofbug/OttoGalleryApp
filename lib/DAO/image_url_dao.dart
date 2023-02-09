import 'package:floor/floor.dart';
import 'package:gallery_app/model/image_dataset/image_dataset.dart';

@dao
abstract class ImageUrlDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFavouriteImageUrl(ImageUrl imageUrl);
}
