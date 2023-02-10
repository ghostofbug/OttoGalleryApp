import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery_app/common/constant.dart';

import '../model/photo_model/photo_model.dart';

final favouritePhotoListProvider =
    StateNotifierProvider<FavouritePhotoListNotifier, List<Photo>>((ref) {
  return FavouritePhotoListNotifier([]);
});

final isLazyLoadProvider = StateProvider<bool>((ref) => true);

class FavouritePhotoListNotifier extends StateNotifier<List<Photo>> {
  FavouritePhotoListNotifier(List<Photo> state) : super([]);
  void setList(List<Photo> list) {
    state = list;
  }

  void addItem(Photo photo) {
    if (state.indexWhere((element) => element.id == photo.id) == -1) {
      state = [...state, photo];
    }
  }

  void insertAtHead(Photo photo) {
    if (state.indexWhere((element) => element.id == photo.id) == -1) {
      state = [photo, ...state];
    }
  }

  void removeItem(Photo photo) {
    List<Photo> copyList = [];
    for (var item in state) {
      copyList.add(item);
    }
    copyList.removeWhere((element) => element.id == photo.id);
    state = copyList;
  }
}

final favouritePageListProvider = StateProvider<int>(((ref) {
  return 1;
}));

final pageListProvider = StateProvider<int>(((ref) {
  return 1;
}));

final photoListProvider =
    StateNotifierProvider<PhotoListNotifier, List<Photo>?>((ref) {
  return PhotoListNotifier(null);
});

class PhotoListNotifier extends StateNotifier<List<Photo>?> {
  PhotoListNotifier(List<Photo>? state) : super(null);

  void setList(List<Photo> list) {
    state = list;
  }

  void addItem(Photo photoDataset) {
    if (state != null) {
      if (state?.indexWhere((element) => element.id == photoDataset.id) == -1) {
        state = [...state!, photoDataset];
      }
    }
  }
}

final selectedTabProvider = StateProvider<int>(
  (ref) {
    return 0;
  },
);
