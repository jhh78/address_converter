import 'package:english_address_converter/utils/app_config.dart';
import 'package:english_address_converter/screens/jp_search.dart';
import 'package:english_address_converter/screens/kr_search.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;
  late final TabController _tabController;
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    debugPrint('>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $info');
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadAd();
    _initPackageInfo();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
    _bannerAd?.dispose();
  }

  void loadAd() {
    _bannerAd = BannerAd(
      adUnitId: AppConfig.bannerAdUnitId(),
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $ad loaded.');
          setState(() {
            _isAdLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('>>>>>>>>>>>>>>>>>> BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load().then((value) {
        setState(() {
          _isAdLoaded = true;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.appTitle,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                'v${_packageInfo.version}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
          bottom: !_isAdLoaded
              ? null
              : TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(
                      text: AppLocalizations.of(context)!.tab1Title,
                    ),
                    Tab(
                      text: AppLocalizations.of(context)!.tab2Title,
                    ),
                  ],
                ),
          centerTitle: true,
        ),
        body: !_isAdLoaded
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                controller: _tabController,
                children: const [KRSearch(), JPSearch()],
              ),
        bottomNavigationBar: _isAdLoaded
            ? SizedBox(
                height: _bannerAd!.size.height.toDouble(),
                width: _bannerAd!.size.width.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              )
            : const SizedBox(),
      ),
    );
  }
}
