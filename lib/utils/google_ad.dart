import 'dart:developer';
import 'dart:io';
import 'package:english_address_converter/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:pocketbase/pocketbase.dart';

class GoogleAds {
  // 배너광고
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

  static Future<void> createAdmobState(dynamic obj, String name) async {
    try {
      final pb = PocketBase(API_URL);

      final body = <String, dynamic>{"name": name, "body": obj.toString()};

      await pb.collection('admob').create(body: body);
    } catch (error) {
      log(error.toString(), name: 'GoogleAds.createAdmobState.error');
    }
  }
}
