import 'package:flutter/foundation.dart';

class AppConfig {
  // 앱 설정 관련
  static String get dbFileName => '202312311715.db';

  static String bannerAdUnitId() {
    if (kReleaseMode) {
      return 'ca-app-pub-9674517651101637/8947720026';
    }

    return 'ca-app-pub-3940256099942544/6300978111';
  }

  static String interstitialAdUnitId() {
    if (kReleaseMode) {
      return 'ca-app-pub-9674517651101637/4168155732';
    }

    return 'ca-app-pub-3940256099942544/1033173712';
  }
}
