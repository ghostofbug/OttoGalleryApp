import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery_app/common/extension.dart';
import 'package:gallery_app/favourite/controller/favourite_page_controller.dart';
import 'package:gallery_app/provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../common/colors.dart';
import '../../common/constant.dart';

class FavouritePage extends ConsumerStatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends ConsumerState<FavouritePage> {
  late FavouritePageController favouritePageController =
      FavouritePageController(context: context, ref: ref);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favouritePageController.getFavouriteImages();
    itemPositionsListener.itemPositions.addListener(() async {
      var max = itemPositionsListener.itemPositions.value
          .where((ItemPosition position) => position.itemLeadingEdge < 1)
          .reduce((ItemPosition max, ItemPosition position) =>
              position.itemLeadingEdge > max.itemLeadingEdge ? position : max)
          .index;
      var favoriteListLength = ref.read(favouriteImageListProvider).length;
      if (max == favoriteListLength - 2) {
        await favouritePageController.getFavouriteImages();
      }
    });
  }

  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  Widget renderBlur(String? blurHash) {
    if (blurHash == null) {
      return SizedBox.shrink();
    } else {
      if (blurHash.length < 6) {
        return SizedBox.shrink();
      } else {
        return BlurHash(hash: blurHash);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var imageList = ref.watch(favouriteImageListProvider);
    if (imageList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_not_supported_outlined,
              size: 48,
            ),
            Text(
              context.loc.noPhotos,
              style: TextStyle(fontSize: FontSize.fontSize16),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 40,
          leading: SizedBox.shrink(),
          backgroundColor: CustomAppTheme.colorBlack,
          title: Text(
            context.loc.favourite,
            style: TextStyle(color: CustomAppTheme.colorWhite),
          )),
      body: ScrollablePositionedList.builder(
          itemPositionsListener: itemPositionsListener,
          itemCount: imageList.length,
          key: PageStorageKey("1"),
          itemBuilder: ((context, index) {
            var image = imageList[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(RouteSetting.imageDetail, arguments: image);
              },
              child: Stack(
                children: [
                  CachedNetworkImage(
                      placeholder: ((context, url) {
                        return SizedBox(
                          child: Center(
                              child: AspectRatio(
                                  aspectRatio:
                                      (image.width ?? 1) / (image.height ?? 1),
                                  child: renderBlur(image.blurHash))),
                        );
                      }),
                      imageBuilder: ((context, imageProvider) {
                        return AspectRatio(
                          aspectRatio: (image.width ?? 1) / (image.height ?? 1),
                          child: Stack(
                            children: [
                              Image(
                                fit: BoxFit.fill,
                                image: imageProvider,
                              ),
                            ],
                          ),
                        );
                      }),
                      imageUrl: image.imageUrls?.regular ?? ""),
                  Positioned(
                    bottom: 5,
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        image.description ?? "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            color: CustomAppTheme.colorTextWhite,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            );
          })),
    );
  }
}
