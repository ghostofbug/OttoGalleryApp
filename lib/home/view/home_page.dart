import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery_app/common/colors.dart';
import 'package:gallery_app/common/constant.dart';
import 'package:gallery_app/common/extension.dart';
import 'package:gallery_app/home/controller/home_controller.dart';
import 'package:gallery_app/provider/provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  late final HomeController homeController =
      HomeController(context: context, ref: ref);

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    if (ref.read(photoListProvider) == null) {
      homeController.requestImage();
    }
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        ref.read(isLazyLoadProvider.notifier).state = true;
        setState(() {
          
        });
        homeController.requestImage();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var photoList = ref.watch(photoListProvider);
    var isLazyLoad = ref.read(isLazyLoadProvider);
    if (photoList == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: ComponentSize.appBarSized,
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
        body: ListView.builder(
            padding: EdgeInsets.zero,
            physics: ClampingScrollPhysics(),
            controller: scrollController,
            key: PageStorageKey(0),
            cacheExtent: MediaQuery.of(context).size.height,
            itemCount: photoList.length + 1,
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
              AnimationController _scale = AnimationController(
                  vsync: this, duration: Duration(milliseconds: 700));
              Animation<double> _scaleAnimation = TweenSequence(
                <TweenSequenceItem<double>>[
                  TweenSequenceItem<double>(
                    tween: Tween(begin: 0.0, end: 1.0)
                        .chain(CurveTween(curve: Curves.linear)),
                    weight: 50.0,
                  ),
                  TweenSequenceItem<double>(
                    tween: Tween(begin: 1.0, end: 0.0)
                        .chain(CurveTween(curve: Curves.linear)),
                    weight: 50.0,
                  ),
                ],
              ).animate(_scale);

              var photo = photoList[index];
              return GestureDetector(
                onDoubleTap: () async {
                  _scale.reset();
                  _scale.forward();

                  homeController.bookmarkPhoto(photo);
                },
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
                                    aspectRatio: (photo.width ?? 1) /
                                        (photo.height ?? 1),
                                    child: BlurWidget(photo.blurHash ?? ""))),
                          );
                        }),
                        imageBuilder: ((context, imageProvider) {
                          return AspectRatio(
                            aspectRatio:
                                (photo.width ?? 1) / (photo.height ?? 1),
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
                                      size: ((photo.width ?? 1) /
                                              (photo.height ?? 1)) *
                                          128,
                                      color: CustomAppTheme.colorWhite,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                        imageUrl: photo.imageUrls?.regular ?? ""),
                    Positioned(
                      bottom: 5,
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
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
            })));
  }
}
