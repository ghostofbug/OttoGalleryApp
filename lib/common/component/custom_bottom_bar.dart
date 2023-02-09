import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/provider.dart';
import '../colors.dart';
import '../constant.dart';
import '../extension.dart';

class CustomBottomBar extends ConsumerStatefulWidget {
  CustomBottomBar({Key? key, required this.setSelectedIndex}) : super(key: key);

  final CallBack<int> setSelectedIndex;
  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends ConsumerState<CustomBottomBar> {

  @override
  Widget build(BuildContext context) {
    var i = ref.watch(selectedTabProvider);
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: CustomAppTheme.colorWhite,
      ),
      height: MediaQuery.of(context).size.height * 0.09,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              ref.read(selectedTabProvider.notifier).state = 0;
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  i == 0 ? Icons.home : Icons.home_outlined,
                  size: 24,
                ),
                Text(
                  context.loc.home,
                  style: TextStyle(
                      fontSize: FontSize.fontSize16,
                      fontWeight: i == 0 ? FontWeight.w500 : FontWeight.w300),
                )
              ],
            ),
          ),
          Container(
            width: 1,
            height: 15,
            color: CustomAppTheme.colorTextBlack,
          ),
          GestureDetector(
            onTap: () {
              ref.read(selectedTabProvider.notifier).state = 1;
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                i == 1
                    ? Icon(
                        Icons.favorite,
                        size: 24,
                      )
                    : Icon(
                        Icons.favorite_outline,
                        size: 24,
                      ),
                Text(
                  context.loc.favourite,
                  style: TextStyle(
                      fontSize: FontSize.fontSize16,
                      fontWeight: i == 1 ? FontWeight.w500 : FontWeight.w300),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
