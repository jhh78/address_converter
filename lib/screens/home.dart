import 'package:flutter/material.dart';
import 'package:flutter_core/models/db.dart';
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

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> jsonList = [];
  DBModel dbModel = DBModel();

  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jsonList = dbModel.doSelect();
    loadAd();
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
            _isLoaded = true;
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
    debugPrint('into build $jsonList');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('英語住所変換'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                    labelText: '変換する住所を入力してください。',
                  ),
                  onSubmitted: (String searchWord) {
                    // TODO::: API처리
                    debugPrint(
                        '???????????????????????????????????????? $searchWord');
                  },
                  textInputAction: TextInputAction.search,
                  maxLines: 5,
                  minLines: 5),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: jsonList.length,
                itemBuilder: (context, builder) {
                  return ListTile(
                    title: Text(jsonList[builder].toString()),
                  );
                },
                separatorBuilder: (context, builder) {
                  return const Divider(
                    height: 2,
                  );
                },
              ),
            )
          ],
        ),
        bottomNavigationBar: _isLoaded
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
