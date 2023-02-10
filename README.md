# Otto Gallery App



## Introduction
The Flutter app for viewing image/photo. Work as a Gallery App

## Support
- Flutter 3.0.0+
- Android SDK21+
- iOS 11+

## Installation 
1. Clone this project via github 
2. run ```flutter pub get``` for install additional library using in app
3. run ```flutter gen-l10n``` for generating translation text file using in app (currently support only English)
4. run ```flutter packages pub run build_runner build``` for automatic generating Database, JSON-Serializable Ojbect
5. run ```flutter run --flavor=uat``` for running Test version of App 
6. Additonally ```flutter run --flavor=prod``` for running Production version of App 

At now, the different between UAT version and Produciton version is app name, app bundle id, google service file (this help mimic realife situation when developer need to work on different environment of app)

Please note: .env file is for demo purpose. In realife, it should be include in gitignore 

## Feature 
- Multiple build configuration using Flutter Flavor combine power of Android flavor and iOS Scheme
- Fully paginate for endless scrolling both Gallery view and Favourite View
- Store local favourite photo using Sqlite 
- Sign in with Google, Sign in With Email/Password using Firebase Auth
- App-ready for supporting multiple language/locale (currently English only, but have room to support other via Flutter Localization)

## Limitation
- User favourite not sync to server when user sign in. It's only store at local device 
- Public Image API restriction quota: 50 request/hour (unsplash api)

## Project Structure 
- Android: Android project of app
- iOS: iOS project of app
- lib/common: common component/controller/constant using in app
- lib/DAO: dao object for accessing database
- lib/database: sqlite database and generating file for sqlite database
- lib/favourite: favorite page/controller 
- lib/home: home page/controller
- lib/login: login/signup 
- lib/l10n: translation for text in app 
- lib/provider: provider for state management 
- lib/model: model using in app
- lib/photo_detail: photo detail screen 

## Library using
- flutter_localizations
  
- flutter_dotenv: ^5.0.2

- dio: ^4.0.6

- flutter_easyloading: ^3.0.5

- logger: ^1.1.0

- json_serializable: ^6.1.5

- json_annotation: ^4.4.0

- flutter_launcher_icons: ^0.10.0

- cached_network_image: ^3.2.0

- flutter_native_splash: ^2.1.6

- connectivity_plus: ^2.0.0

- internet_connection_checker: ^0.0.1+3

- cupertino_icons: ^1.0.2

- async: ^2.4.1

- app_tracking_transparency: ^2.0.3

- flutter_riverpod: ^2.1.1

- flutter_blurhash: ^0.7.0

- scrollable_positioned_list: ^0.3.5

- photo_view: ^0.14.0

- floor: ^1.4.1

- firebase_core: ^2.5.0

- firebase_auth: ^4.2.6

- google_sign_in: ^5.0.0



