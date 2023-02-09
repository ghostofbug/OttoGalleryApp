// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_dataset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageDataset _$ImageDatasetFromJson(Map<String, dynamic> json) => ImageDataset(
      code: json['code'] as String?,
      id: json['id'] as String?,
      createdAt: json['created_at'] as String?,
      description: json['description'] as String?,
      favouriteAddDate: json['favourite_add_date'] as int?,
      height: (json['height'] as num?)?.toDouble(),
      name: json['name'] as String?,
      updatedAt: json['updated_at'] as String?,
      blurHash: json['blur_hash'] as String?,
      width: (json['width'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ImageDatasetToJson(ImageDataset instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'width': instance.width,
      'height': instance.height,
      'description': instance.description,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'blur_hash': instance.blurHash,
      'favourite_add_date': instance.favouriteAddDate,
    };
