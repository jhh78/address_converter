import 'package:flutter/material.dart';
import 'package:flutter_core/screens/search_word.dart';
import 'package:flutter_core/screens/search_zip.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

//TODO:::핸드폰에 데이터 저장하기
//TODO:::핸드폰에 데이터 불러오기
//TODO:::핸드폰에 데이터 삭제하기
//TODO:::API 연동하기
//TODO:::UI만들기

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;
  late final _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadAd();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
    _bannerAd?.dispose();
  }

  void loadAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
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
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('英語住所変換'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                text: '郵便番号検索',
              ),
              Tab(
                text: '住所検索',
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: TabBarView(
          controller: _tabController,
          children: [SearchZip(), SearchWord()],
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
