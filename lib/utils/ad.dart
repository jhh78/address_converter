import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const String location = "lib/services/ad_manager.dart";

class ADManager extends GetxService {
  RxBool isADLoaded = false.obs;
  String _getADUnitId() {
    if (Platform.isAndroid) {
      return kReleaseMode ? "ca-app-pub-9674517651101637/9175886166" : "ca-app-pub-3940256099942544/5224354917";
    } else if (Platform.isIOS) {
      return kReleaseMode ? "ca-app-pub-9674517651101637/5943218161" : "ca-app-pub-3940256099942544/1712485313";
    }

    throw Exception("Unsupported platform");
  }

  Future loadAd() async {
    try {
      final Completer<void> completer = Completer<void>();
      isADLoaded.value = true;
      await InterstitialAd.load(
          adUnitId: _getADUnitId(),
          request: const AdRequest(),
          adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad) async {
              log('Ad loaded. $ad');
              await ad.show();

              ad.fullScreenContentCallback = FullScreenContentCallback(
                onAdShowedFullScreenContent: (ad) {
                  log('Ad showed fullscreen content: $ad');
                },
                onAdImpression: (ad) {
                  log('Ad impression: $ad');
                  ad.dispose();
                  isADLoaded.value = false;
                },
                onAdFailedToShowFullScreenContent: (ad, err) async {
                  ad.dispose();
                  completer.completeError(Exception('Ad failed to show fullscreen content: $err'));
                },
                onAdDismissedFullScreenContent: (ad) async {
                  ad.dispose();
                  completer.completeError(Exception('Ad dismissed fullscreen content: $ad'));
                },
                onAdClicked: (ad) {
                  log('Ad clicked: $ad');
                },
              );
            },
            onAdFailedToLoad: (error) {
              completer.completeError(Exception('Ad failed to load: $error'));
            },
          ));

      await completer.future;
    } catch (e) {
      isADLoaded.value = false;
      log(e.toString());
      rethrow;
    }
  }
}
