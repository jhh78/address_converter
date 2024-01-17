import 'dart:io';

import 'package:flutter/foundation.dart';

class AppConfig {
  // 앱 설정 관련
  static String get dbFileName => '20240117-1600.db';

  static String bannerAdUnitId() {
    if (Platform.isAndroid) {
      return kReleaseMode
          ? 'ca-app-pub-9674517651101637/8947720026'
          : 'ca-app-pub-3940256099942544/6300978111';
    } else {
      return kReleaseMode
          ? 'ca-app-pub-9674517651101637/9257604964'
          : 'ca-app-pub-3940256099942544/2934735716';
    }
  }

  // 전면 광고
  static String interstitialAdUnitId() {
    if (Platform.isAndroid) {
      return kReleaseMode
          ? 'ca-app-pub-9674517651101637/4168155732'
          : 'ca-app-pub-3940256099942544/1033173712';
    } else {
      return kReleaseMode
          ? 'ca-app-pub-9674517651101637/7200102041'
          : 'ca-app-pub-3940256099942544/4411468910';
    }
  }
}
