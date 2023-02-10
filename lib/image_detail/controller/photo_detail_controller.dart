import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery_app/common/extension.dart';
import 'package:gallery_app/model/photo_model/photo_model.dart';

import '../../common/colors.dart';
import '../../common/storage_controller.dart';
import '../../provider/provider.dart';

class PhotoDetailController {
  final BuildContext context;
  final WidgetRef ref;
  final Photo photo;

  PhotoDetailController(
      {required this.context, required this.ref, required this.photo});

  void onClickFavourite(bool isFavourite) async {
    if (isFavourite) {
      await StorageController.database?.imageDao.insertFavouritePhoto(photo);
      ref.read(favouritePhotoListProvider.notifier).insertAtHead(photo);
    } else {
      await StorageController.database?.imageDao.deleteFavouritePhoto(photo);
      ref.read(favouritePhotoListProvider.notifier).insertAtHead(photo);
    }
  }

  Future<void> showImageInfoModal() async {
    await showModalBottomSheet<Widget>(
        context: context,
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: ((context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 5,
                width: 52,
                decoration: BoxDecoration(
                    color: CustomAppTheme.colorWhite,
                    borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: CustomAppTheme.colorBlack,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            context.loc.createdAt,
                            style: TextStyle(color: CustomAppTheme.colorWhite),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            photo.createdAt ?? "-",
                            style: TextStyle(color: CustomAppTheme.colorWhite),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            context.loc.description,
                            style: TextStyle(color: CustomAppTheme.colorWhite),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            photo.description ?? "-",
                            style: TextStyle(color: CustomAppTheme.colorWhite),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            context.loc.raw,
                            style: TextStyle(color: CustomAppTheme.colorWhite),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            photo.imageUrls?.raw ?? "-",
                            style: TextStyle(color: CustomAppTheme.colorWhite),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            context.loc.dimension,
                            style: TextStyle(color: CustomAppTheme.colorWhite),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${photo.width} x ${photo.height}',
                            style: TextStyle(color: CustomAppTheme.colorWhite),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              )
            ],
          );
        }));
  }
}
