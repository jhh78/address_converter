import 'package:english_address_converter/providers/system.dart';
import 'package:english_address_converter/utils/constants.dart';
import 'package:english_address_converter/utils/messages.dart';
import 'package:flutter/material.dart';
import 'package:english_address_converter/screens/home.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:upgrader/upgrader.dart';

import 'utils/styles.dart';

// TODO ::: AI를 이용하게 수정, DB 이용 폐기
// 리워드 광고를 통하여 포인트를 획득후 사용하는 형식으로 변경

// TODO ::: 클립보드 복사 기능 추가
// 클립보드에 복사된 내용을 볼수 있는 화면추가

// TODO ::: 리워드 광고 추가

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await MobileAds.instance.initialize();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  // Hive 초기화 및 박스 열기
  await Hive.initFlutter(appDocumentDir.path);
  await Hive.openBox(LOCAL_BOX);

  if (kDebugMode) {
    await Upgrader.clearSavedSettings();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final SystemProvider systemProvider = Get.put(SystemProvider());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        theme: ThemeData.light().copyWith(
          textTheme: getLightTextTheme(context),
        ),
        darkTheme: ThemeData.dark().copyWith(
          textTheme: getDarkTextTheme(context),
        ),
        themeMode: systemProvider.themeMode.value,
        translations: Messages(),
        locale: const Locale('ko', 'KR'),
        fallbackLocale: const Locale('ko', 'KR'),
        home: UpgradeAlert(
          dialogStyle: UpgradeDialogStyle.cupertino,
          child: HomeScreen(),
        ),
      );
    });
  }
}
