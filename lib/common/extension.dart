import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef CallBack<T> = void Function(T value);

extension LocalizedBuildContext on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this);
}

Widget BlurWidget(String? blurHash) {
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

