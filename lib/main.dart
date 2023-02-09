import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery_app/common/colors.dart';
import 'package:gallery_app/image_detail/view/image_detail_view.dart';
import 'package:gallery_app/model/image_dataset/image_dataset.dart';

import 'common/constant.dart';
import 'common/environment.dart';
import 'common/storage_controller.dart';
import 'main/view/main_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: Environment.fileName);

  await AppTrackingTransparency.requestTrackingAuthorization();
  await StorageController.buildDatabase();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(ProviderScope(child: const MyApp()));
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  Locale? _locale;
  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void setupLoading() {
    EasyLoading.instance.loadingStyle = EasyLoadingStyle.light;
    EasyLoading.instance.maskColor = Colors.transparent;
    EasyLoading.instance.backgroundColor =
        CustomAppTheme.colorWhite.withOpacity(0.5);
    EasyLoading.instance.indicatorWidget = CircularProgressIndicator.adaptive();
    EasyLoading.instance.maskType = EasyLoadingMaskType.custom;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupLoading();

    //set default locale is En-US// Support multiple locale/language later
    _locale = AppLocale.engLocale;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GalleryApp',
      locale: _locale,
      navigatorKey: navigatorKey,
      builder: EasyLoading.init(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: RouteSetting.main,
      onGenerateRoute: (parameters) {
        WidgetBuilder builder = (BuildContext _) => MainPage();
        switch (parameters.name) {
          case RouteSetting.main:
            builder = (BuildContext _) => MainPage();
            break;
          case RouteSetting.imageDetail:
            builder = (BuildContext _) =>
                ImageDetailView(image: parameters.arguments as ImageDataset);
            break;
          default:
            break;
        }
        return MaterialPageRoute(builder: builder, settings: parameters);
      },
      supportedLocales: const [
        Locale('en', ''),
      ],
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Gallery App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var isDeviceConnected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
