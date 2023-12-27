import 'package:flutter/foundation.dart';

class AppConfig {
  // 앱 설정 관련
  static String get dbFileName => 'app.202312271800.db';
  static String bannerAdUnitId() {
    if (kReleaseMode) {
      return 'ca-app-pub-9674517651101637/8947720026';
    }

    return 'ca-app-pub-3940256099942544/6300978111';
  }

  // 앱 타이틀
  static String get appTitle => '住所変換アプリ（日➡英）';

  // 우편번호로 검색 화면
  static String get zipCodeSearchTitle => '郵便番号で検索';
  static String get zipCodeSearchHint => '郵便番号をハイフンなしで入力してください';

  // 주소로 검색 화면
  static String get addressSearchTitle => '住所で検索';
  static String get addressSearchHint => '住所を入力してください';

  // 주소 검색 결과 없음
  static String get noSearchResult => '検索結果がありません';
}
