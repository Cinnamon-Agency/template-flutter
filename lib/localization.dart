import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Localization extends Translations {
  static Locale? get locale => Get.deviceLocale;

  /// If the device is set to some language which is not in this `Map`,
  /// language will fallbact to [en-US]
  static const fallbackLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'hr': hr,
      };

  /// English strings
  final en = {
    'appName': 'Cinnamon Flutter Template',
  };

  /// Croatian strings
  final hr = {
    'appName': 'Cinnamon Flutter Template',
  };
}
