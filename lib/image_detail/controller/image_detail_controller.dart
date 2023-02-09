import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery_app/common/extension.dart';
import 'package:gallery_app/model/image_dataset/image_dataset.dart';
import '../../common/colors.dart';
import '../../common/storage_controller.dart';
import '../../provider/provider.dart';

class ImageDetailController {
  final BuildContext context;
  final WidgetRef ref;
  final ImageDataset image;

  ImageDetailController(
      {required this.context, required this.ref, required this.image});

  void onClickFavourite(bool isFavourite) async {
    if (isFavourite) {
      await StorageController.database?.imageDao.insertFavouriteImage(image);
      ref.read(favouriteImageListProvider.notifier).addItem(image);
    } else {
      await StorageController.database?.imageDao.deleteFavouriteImage(image);
      ref.read(favouriteImageListProvider.notifier).removeItem(image);
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
                            image.createdAt ?? "-",
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
                            image.description ?? "-",
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
                            image.imageUrls?.raw ?? "-",
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
                            '${image.width} x ${image.height}',
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
