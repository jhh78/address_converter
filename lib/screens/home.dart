import 'dart:developer';

import 'package:english_address_converter/utils/google_ad.dart';
import 'package:english_address_converter/screens/jp_search.dart';
import 'package:english_address_converter/screens/kr_search.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;
  late final TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadBannerAd();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
    _bannerAd?.dispose();
  }

  void loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: GoogleAds.bannerAdUnitId(),
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          GoogleAds.createAdmobState(ad.responseInfo, 'BannerAd loaded.');
          log('>> $ad loaded.', name: 'BannerAd');
          setState(() {
            _isAdLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          GoogleAds.createAdmobState(err, 'BannerAd failed.');
          log('>> BannerAd failed to load: $err', name: 'BannerAd');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load().then(
        (value) {
          setState(() {
            _isAdLoaded = true;
          });
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.appTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
      body: !_isAdLoaded
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: const [
                      KRSearch(),
                      JPSearch(),
                    ],
                  ),
                ),
                _isAdLoaded
                    ? SizedBox(
                        height: _bannerAd!.size.height.toDouble(),
                        width: _bannerAd!.size.width.toDouble(),
                        child: AdWidget(ad: _bannerAd!),
                      )
                    : const SizedBox(),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey[500],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'KR ▶︎ EN',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'JP ▶︎ EN',
          ),
        ],
        selectedItemColor: Colors.amber[800],
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
