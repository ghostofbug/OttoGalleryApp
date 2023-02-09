import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery_app/common/colors.dart';
import 'package:gallery_app/common/constant.dart';
import 'package:gallery_app/common/extension.dart';
import 'package:gallery_app/common/storage_controller.dart';
import 'package:gallery_app/home/controller/home_controller.dart';
import 'package:gallery_app/provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  late final HomeController homeController =
      HomeController(context: context, ref: ref);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    homeController.endListLength =
        homeController.endListLength * (ref.read(pageListProvider) - 1);
    itemPositionsListener.itemPositions.addListener(() async {
      //finding current index is scrolling to
      var max = itemPositionsListener.itemPositions.value
          .where((ItemPosition position) => position.itemLeadingEdge < 1)
          .reduce((ItemPosition max, ItemPosition position) =>
              position.itemLeadingEdge > max.itemLeadingEdge ? position : max)
          .index;
      if (max == homeController.endListLength) {
        homeController.endListLength = homeController.endListLength + 8;
        await homeController.requestImage();
      }
    });
    super.initState();
  }

  ScrollController scrollController = ScrollController();
  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  @override
  Widget build(BuildContext context) {
    var imageList = ref.watch(imageListProvider);
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 40,
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(RouteSetting.login);
              },
              child: Image.asset("assets/app_icon.png")),
          title: Text(context.loc.galleryApp),
          backgroundColor: Colors.transparent.withOpacity(0.4),
          shadowColor: null,
          elevation: 0,
        ),
        body: ScrollablePositionedList.builder(
            itemScrollController: itemScrollController,
            itemPositionsListener: itemPositionsListener,
            key: PageStorageKey(0),
            itemCount: imageList.length + 1,
            itemBuilder: ((context, index) {
              late AnimationController _scale;
              late Animation<double> _scaleAnimation;
              _scale = AnimationController(
                  vsync: this, duration: Duration(milliseconds: 1000));
              _scaleAnimation = TweenSequence(
                <TweenSequenceItem<double>>[
                  TweenSequenceItem<double>(
                    tween: Tween(begin: 0.0, end: 1.0)
                        .chain(CurveTween(curve: Curves.ease)),
                    weight: 50.0,
                  ),
                  TweenSequenceItem<double>(
                    tween: Tween(begin: 1.0, end: 0.0)
                        .chain(CurveTween(curve: Curves.ease)),
                    weight: 50.0,
                  ),
                ],
              ).animate(_scale);
              if (index == imageList.length) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var image = imageList[index];
              return GestureDetector(
                onDoubleTap: () async {
                  _scale.reset();
                  _scale.forward();
                  image.favouriteAddDate =
                      DateTime.now().millisecondsSinceEpoch;
                  await StorageController.database?.imageDao
                      .insertFavouriteImage(image);
                  await StorageController.database?.imageUrlDao
                      .insertFavouriteImageUrl(image.imageUrls!);
                  ref.read(favouriteImageListProvider.notifier).addItem(image);
                },
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
                                    aspectRatio: (image.width ?? 1) /
                                        (image.height ?? 1),
                                    child:
                                        BlurHash(hash: image.blurHash ?? ""))),
                          );
                        }),
                        imageBuilder: ((context, imageProvider) {
                          return AspectRatio(
                            aspectRatio:
                                (image.width ?? 1) / (image.height ?? 1),
                            child: Stack(
                              children: [
                                Image(
                                  fit: BoxFit.fill,
                                  image: imageProvider,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: ScaleTransition(
                                    scale: _scaleAnimation,
                                    child: Icon(
                                      Icons.favorite,
                                      size: ((image.width ?? 1) /
                                              (image.height ?? 1)) *
                                          128,
                                      color: CustomAppTheme.colorWhite,
                                    ),
                                  ),
                                )
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
            })));
  }
}
