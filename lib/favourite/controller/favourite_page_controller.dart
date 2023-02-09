import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery_app/common/storage_controller.dart';
import 'package:gallery_app/model/image_dataset/image_dataset.dart';
import 'package:gallery_app/provider/provider.dart';

class FavouritePageController {
  final WidgetRef ref;
  final BuildContext context;

  FavouritePageController({required this.context, required this.ref});

  Future<List<ImageDataset>?> getFavouriteImages() async {
    var currentList = ref.read(favouriteImageListProvider);
    var page = ref.read(favouritePageListProvider);
    if (currentList.isNotEmpty && currentList.length % 5 == 0) {
      ref.read(favouritePageListProvider.notifier).state =
          currentList.length ~/ 5 + 1;
    }
    var result =
        await StorageController.database?.imageDao.getFavouriteImages(page);
    if (result != null && result.isNotEmpty) {
      for (var item in result) {
        ref.read(favouriteImageListProvider.notifier).addItem(item);
      }
    }
    return result;
  }
}
