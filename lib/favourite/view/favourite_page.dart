import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery_app/common/extension.dart';
import 'package:gallery_app/favourite/controller/favourite_page_controller.dart';
import 'package:gallery_app/provider/provider.dart';

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

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    favouritePageController.getFavouriteImages();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          ref.read(isLazyLoadProvider.notifier).state = true;
          setState(() {});
          favouritePageController.getFavouriteImages();
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var photoList = ref.watch(favouritePhotoListProvider);
    var isLazyLoad = ref.watch(isLazyLoadProvider);
    if (photoList.isEmpty) {
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
          centerTitle: true,
          toolbarHeight: ComponentSize.appBarSized,
          leading: SizedBox.shrink(),
          backgroundColor: CustomAppTheme.colorBlack,
          actions: [],
          title: Text(
            context.loc.favourite,
            style: TextStyle(color: CustomAppTheme.colorWhite),
          )),
      body: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: photoList.length + 1,
          controller: scrollController,
          key: PageStorageKey("1"),
          itemBuilder: ((context, index) {
            if (index == photoList.length) {
              if (isLazyLoad) {
                return Container(
                    color: CustomAppTheme.colorBlack.withOpacity(0.3),
                    height: 500,
                    child: Center(
                        child: CircularProgressIndicator(
                      color: CustomAppTheme.colorWhite,
                    )));
              }
              return SizedBox.shrink();
            }
            var photo = photoList[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(RouteSetting.imageDetail, arguments: photo);
              },
              child: Stack(
                children: [
                  CachedNetworkImage(
                      placeholder: ((context, url) {
                        return SizedBox(
                          child: Center(
                              child: AspectRatio(
                                  aspectRatio:
                                      (photo.width ?? 1) / (photo.height ?? 1),
                                  child: BlurWidget(photo.blurHash))),
                        );
                      }),
                      imageBuilder: ((context, imageProvider) {
                        return AspectRatio(
                          aspectRatio: (photo.width ?? 1) / (photo.height ?? 1),
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
                      imageUrl: photo.imageUrls?.regular ?? ""),
                  Positioned(
                    bottom: 5,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: PaddingConstants.padding10,
                          right: PaddingConstants.padding10),
                      child: Text(
                        photo.description ?? "",
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
