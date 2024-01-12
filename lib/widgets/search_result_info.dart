// 주소양식 : マンションの名前, 部屋番号, 番地, 市町村, 都道府県, 郵便番号, 国名
import 'package:english_address_converter/utils/app_config.dart';
import 'package:english_address_converter/widgets/search_result_text_block.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ResultInfo extends StatefulWidget {
  final dynamic info;
  final String lang;
  final String koreaName = "Republic of Korea";
  final String japanName = "Japan";

  const ResultInfo({Key? key, required this.info, required this.lang})
      : super(key: key);

  @override
  State<ResultInfo> createState() => _ResultInfoState();
}

class _ResultInfoState extends State<ResultInfo> {
  InterstitialAd? _interstitialAd;
  final String _adUnitId = AppConfig.interstitialAdUnitId();
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  /// Loads an interstitial ad.
  void _loadAd() {
    InterstitialAd.load(
        adUnitId: _adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (InterstitialAd ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {
              debugPrint('?????????? onAdShowedFullScreenContent');
            },
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {
              debugPrint('???????????? onAdImpression');
            },
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
              ad.dispose();
            },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
            },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {
              debugPrint('???????????? onAdClicked');
            });

            // Keep a reference to the ad so you can show it later.
            ad.show();
            setState(() {
              _isAdLoaded = true;
            });
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            // ignore: avoid_print
            print('InterstitialAd failed to load: $error');
            setState(() {
              _isAdLoaded = true;
            });
          },
        ));
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
        final info = widget.info;
    final counrty = widget.lang == 'ko' ? widget.koreaName : widget.japanName;
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.searchResultTitle),
          centerTitle: true,
        ),
        body: !_isAdLoaded
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Card(
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                  AppLocalizations.of(context)!
                                      .addressDialogHintDescriptionC,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Colors.redAccent,
                                      )),
                              Text(
                                  AppLocalizations.of(context)!
                                      .addressDialogHintDescriptionD,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Colors.redAccent,
                                      )),
                              Text(
                                  AppLocalizations.of(context)!
                                      .addressDialogHintDescriptionE,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Colors.redAccent,
                                      )),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Card(
                          color: Colors.white12,
                          // Define the shape of the card
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          // Define how the card's content should be clipped
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          // Define the child widget of the card
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of(context)!
                                      .searchResultCartTitle1,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SearchResultTextBlock(
                                  label: "Street",
                                  value: info.enStreet.toString() ?? ' ',
                                ),
                                const Divider(
                                  height: 10,
                                  color: Colors.white38,
                                ),
                                SearchResultTextBlock(
                                  label: "Town",
                                  value: info.enTown.toString(),
                                ),
                                const Divider(
                                  height: 10,
                                  color: Colors.white38,
                                ),
                                SearchResultTextBlock(
                                  label: "City",
                                  value: info.enCity.toString(),
                                ),
                                const Divider(
                                  height: 10,
                                  color: Colors.white38,
                                ),
                                SearchResultTextBlock(
                                  label: "State / Province / Region",
                                  value: info.enPrefectures.toString(),
                                ),
                                const Divider(
                                  height: 10,
                                  color: Colors.white38,
                                ),
                                SearchResultTextBlock(
                                  label: "Zip Code (Postal Code)",
                                  value: info.zip.toString(),
                                ),
                                const Divider(
                                  height: 10,
                                  color: Colors.white38,
                                ),
                                SearchResultTextBlock(
                                  label: "Country",
                                  value: counrty,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Card(
                          color: Colors.white12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of(context)!
                                      .searchResultCartTitle2,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .searchResultApendTIp,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                          color: Colors.tealAccent,
                                        ),
                                  ),
                                ),
                                if (info.enStreet != null)
                                  Text(
                                    "${info.enStreet}",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                    overflow: TextOverflow.clip,
                                    maxLines: 2,
                                  ),
                                if (info.enTown != null && info.enTown != '')
                                  Text(
                                    "${info.enTown}",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                    overflow: TextOverflow.clip,
                                    maxLines: 2,
                                  ),
                                Text(
                                  "${info.enCity}",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  overflow: TextOverflow.clip,
                                  maxLines: 2,
                                ),
                                Text(
                                  "${info.enPrefectures} ${info.zip} ",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  overflow: TextOverflow.clip,
                                  maxLines: 2,
                                ),
                                Text(
                                  counrty,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  overflow: TextOverflow.clip,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
