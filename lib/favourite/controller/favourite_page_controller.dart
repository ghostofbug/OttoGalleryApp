import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery_app/common/storage_controller.dart';

import 'package:gallery_app/provider/provider.dart';

import '../../model/photo_model/photo_model.dart';

class FavouritePageController {
  final WidgetRef ref;
  final BuildContext context;

  FavouritePageController({required this.context, required this.ref});

  Future<List<Photo>?> getFavouriteImages() async {
    var page = ref.read(favouritePageListProvider);
    var result =
        await StorageController.database?.imageDao.getFavouritePhotos(page);
    if (result != null && result.isNotEmpty) {
      for (var item in result) {
        ref.read(favouritePhotoListProvider.notifier).addItem(item);
      }
      var currentList = ref.read(favouritePhotoListProvider);
      if (currentList.isNotEmpty && currentList.length % 5 == 0) {
        ref.read(favouritePageListProvider.notifier).state =
            currentList.length ~/ 5 + 1;
      }
    }
    ref.read(isLazyLoadProvider.notifier).state = false;
    return result;
  }
}
