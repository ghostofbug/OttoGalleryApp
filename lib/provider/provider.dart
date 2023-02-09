import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery_app/model/image_dataset/image_dataset.dart';

import '../common/constant.dart';
import '../common/storage_controller.dart';



final favouriteImageListProvider =
    StateNotifierProvider<FavouriteImageListNotifier, List<ImageDataset>>(
        (ref) {
  return FavouriteImageListNotifier([]);
});

class FavouriteImageListNotifier extends StateNotifier<List<ImageDataset>> {
  FavouriteImageListNotifier(List<ImageDataset> state) : super([]);

  void setList(List<ImageDataset> list) {
    state = list;
  }

  void addItem(ImageDataset imageDataset) {
    if (state.indexWhere((element) => element.id == imageDataset.id) == -1) {
      state = [...state, imageDataset];
    }
  }

  void removeItem(ImageDataset imageDataset) {
    List<ImageDataset> copyList = [];
    for (var item in state) {
      copyList.add(item);
    }
    copyList.removeWhere((element) => element.id == imageDataset.id);
    state = copyList;
  }
}

final favouritePageListProvider = StateProvider<int>(((ref) {
  return 1;
}));

final pageListProvider = StateProvider<int>(((ref) {
  return 1;
}));

final imageListProvider =
    StateNotifierProvider<ImageListNotifier, List<ImageDataset>>((ref) {
  return ImageListNotifier([]);
});

class ImageListNotifier extends StateNotifier<List<ImageDataset>> {
  ImageListNotifier(List<ImageDataset> state) : super([]);

  void setList(List<ImageDataset> list) {
    state = list;
  }

  void addItem(ImageDataset categoryDataset) {
    state = [...state, categoryDataset];
  }
}

final selectedTabProvider = StateProvider<int>(
  (ref) {
    return 0;
  },
);
