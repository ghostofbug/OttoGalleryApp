import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
part 'image_dataset.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
@Entity(tableName: 'FAVOURITE_IMAGE')
class ImageDataset {
  @primaryKey
  String? id;
  String? code;
  String? name;
  double? width;
  double? height;

  @JsonKey(ignore: true)
  @ignore
  ImageUrl? imageUrls;

  String? description;
  String? createdAt;
  String? updatedAt;
  String? blurHash;
  int? favouriteAddDate;

  ImageDataset(
      {this.code,
      this.id,
      this.createdAt,
      this.description,
      this.favouriteAddDate,
      this.height,
      this.name,
      this.updatedAt,
      this.blurHash,
      this.imageUrls,
      this.width});

  factory ImageDataset.fromJson(Map<String, dynamic> json) {
    var image = _$ImageDatasetFromJson(json);
    if (json["urls"] is Map<String, dynamic>) {
      image.imageUrls = ImageUrl.ImageUrlFromJson(json["urls"]);
      image.imageUrls?.id = image.id;
    }
    return image;
  }

  Map<String, dynamic> toJson() => _$ImageDatasetToJson(this);
}

@Entity(tableName: 'FAVOURITE_IMAGE_URLS')
class ImageUrl {
  @primaryKey
  String? id;
  String? raw;
  String? full;
  String? regular;
  String? small;
  String? thumb;

  ImageUrl(
      {this.id, this.full, this.raw, this.regular, this.small, this.thumb});

  static ImageUrl ImageUrlFromJson(Map<String, dynamic> json) => ImageUrl(
        raw: json['raw'] as String?,
        full: json['full'] as String?,
        regular: json['regular'] as String?,
        small: json['small'] as String?,
        thumb: json['thumb'] as String?,
      );
}
