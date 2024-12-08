import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ko_KR': {
          'addressConverter': '영어주소 변환기',
        },
        'ja_JP': {
          'addressConverter': '英語住所変換器',
        },
        'en_US': {
          'addressConverter': 'Address Converter',
        },
      };
}
