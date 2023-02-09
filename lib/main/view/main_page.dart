import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery_app/common/colors.dart';
import 'package:gallery_app/favourite/view/favourite_page.dart';
import 'package:gallery_app/home/view/home_page.dart';
import 'package:gallery_app/provider/provider.dart';

import '../../common/component/custom_bottom_bar.dart';

class MainPage extends ConsumerStatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  final List<Widget> pages = <Widget>[HomePage(), FavouritePage()];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var selectTab = ref.watch(selectedTabProvider);
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            backgroundColor: CustomAppTheme.colorBackground,
            body: Stack(
              children: [
                pages[selectTab],
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomBottomBar(setSelectedIndex: ((value) {
                      ref.read(selectedTabProvider.notifier).state = value;
                    })),
                  ),
                )
              ],
            )));
  }
}
