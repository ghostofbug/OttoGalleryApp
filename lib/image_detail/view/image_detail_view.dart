import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery_app/common/colors.dart';
import 'package:gallery_app/common/storage_controller.dart';
import 'package:gallery_app/image_detail/controller/image_detail_controller.dart';
import 'package:gallery_app/model/image_dataset/image_dataset.dart';
import 'package:photo_view/photo_view.dart';

class ImageDetailView extends ConsumerStatefulWidget {
  ImageDetailView({Key? key, required this.image}) : super(key: key);

  ImageDataset image;

  @override
  _ImageDetailViewState createState() => _ImageDetailViewState();
}

class _ImageDetailViewState extends ConsumerState<ImageDetailView> {
  var isFavourite = false;

  bool hideUIElement = false;

  late ImageDetailController imageDetailController =
      ImageDetailController(context: context, ref: ref, image: widget.image);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StorageController.database?.imageDao
        .checkExistFavoriteImage(widget.image.id ?? "")
        .then((value) {
      setState(() {
        isFavourite = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var image = imageDetailController.image;
    return Scaffold(
      backgroundColor: CustomAppTheme.colorBlack.withOpacity(0.6),
      body: Stack(children: [
        Align(
          alignment: Alignment.center,
          child: CachedNetworkImage(
            imageUrl: image.imageUrls?.regular ?? "",
            placeholder: ((context, url) {
              return SizedBox(
                child: Center(
                    child: AspectRatio(
                        aspectRatio: (image.width ?? 1) / (image.height ?? 1),
                        child: BlurHash(hash: image.blurHash ?? ""))),
              );
            }),
            imageBuilder: ((context, imageProvider) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    hideUIElement = !hideUIElement;
                  });
                },
                child: PhotoView(
                  minScale: PhotoViewComputedScale.contained,
                  imageProvider: imageProvider,
                ),
              );
            }),
          ),
        ),
        Visibility(
          visible: !hideUIElement,
          child: Positioned(
            top: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: IconButton(
                      iconSize: 32,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                      )),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    image.description ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: CustomAppTheme.colorWhite,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: IconButton(
                      iconSize: 32,
                      onPressed: () {
                        imageDetailController.showImageInfoModal();
                      },
                      icon: Icon(
                        Icons.info,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: !hideUIElement,
          child: Positioned(
            right: 10,
            bottom: 50,
            child: ElevatedButton(
              onPressed: () async {
                setState(() {
                  isFavourite = !isFavourite;
                });
                imageDetailController.onClickFavourite(isFavourite);
              },
              child: isFavourite
                  ? Icon(Icons.favorite, color: Colors.red)
                  : Icon(Icons.favorite_border, color: Colors.black),
              style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                  backgroundColor: CustomAppTheme.colorWhite
                  ),
            ),
          ),
        )
      ]),
    );
  }
}
