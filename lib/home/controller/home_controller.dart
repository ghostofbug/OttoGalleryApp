import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery_app/common/constant.dart';
import 'package:gallery_app/common/http_client_service.dart';
import 'package:gallery_app/model/photo_model/photo_model.dart';
import 'package:gallery_app/provider/provider.dart';

import '../../common/storage_controller.dart';

class HomeController {
  final BuildContext context;
  final WidgetRef ref;

  Future<void> bookmarkPhoto(Photo photo) async {
    photo.favouriteAddDate = DateTime.now().millisecondsSinceEpoch;
    await StorageController.database?.imageDao.insertFavouritePhoto(photo);
    await StorageController.database?.imageUrlDao
        .insertFavouriteImageUrl(photo.imageUrls!);
    ref.read(favouritePhotoListProvider.notifier).insertAtHead(photo);
  }

  HomeController({required this.context, required this.ref});

  Future<void> requestImage() async {
    var apiUrl = '/photos';
    Map<String, dynamic> parameter = {};
    parameter["page"] = ref.read(pageListProvider);

    HttpClientService().requestTo(
        url: apiUrl,
        method: HttpMethod.GET,
        parameters: parameter,
        isDisplayLoading: false,
        success: (result) {
          if (result is List<dynamic>) {
            if (ref.read(photoListProvider) == null) {
              ref.read(photoListProvider.notifier).setList([]);
            }

            for (var item in result) {
              ref
                  .read(photoListProvider.notifier)
                  .addItem(Photo.fromJson(item));
            }
            if (result.isNotEmpty) {
              ref.read(pageListProvider.notifier).state =
                  ref.read(pageListProvider.notifier).state + 1;
            }
            ref.read(isLazyLoadProvider.notifier).state = false;
          }
        },
        failure: (error) {
          ref.read(isLazyLoadProvider.notifier).state = false;
        });
  }
}
