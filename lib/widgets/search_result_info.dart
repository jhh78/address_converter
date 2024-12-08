// 주소양식 : マンションの名前, 部屋番号, 番地, 市町村, 都道府県, 郵便番号, 国名
import 'package:english_address_converter/widgets/search_result_text_block.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ResultInfo extends StatefulWidget {
  final String koreaName = "Republic of Korea";
  final String japanName = "Japan";

  const ResultInfo({super.key});

  @override
  State<ResultInfo> createState() => _ResultInfoState();
}

class _ResultInfoState extends State<ResultInfo> {
  InterstitialAd? _interstitialAd;

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final info = Get.arguments['info'];
    final counrty = Get.arguments['lang'] == 'ko' ? widget.koreaName : widget.japanName;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Address Information",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                      Text("The address information is displayed in English.",
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Colors.redAccent,
                              )),
                      Text("If you want to see the address information in the original language, please refer to the following.",
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Colors.redAccent,
                              )),
                      Text("If you want to see the address information in the original language, please refer to the following.",
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
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
                          "Address Information",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SearchResultTextBlock(
                          label: "Street",
                          value: info.enStreet == null ? '' : info.enStreet.toString(),
                        ),
                        const Divider(
                          height: 10,
                          color: Colors.white38,
                        ),
                        SearchResultTextBlock(
                          label: "Town",
                          value: info.enTown == null ? '' : info.enTown.toString(),
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
                          "Address Information",
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
                            "The address information is displayed in English.",
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                  color: Colors.tealAccent,
                                ),
                          ),
                        ),
                        if (info.enStreet != null)
                          Text(
                            "${info.enStreet}",
                            style: Theme.of(context).textTheme.titleMedium,
                            overflow: TextOverflow.clip,
                            maxLines: 2,
                          ),
                        if (info.enTown != null && info.enTown != '')
                          Text(
                            "${info.enTown}",
                            style: Theme.of(context).textTheme.titleMedium,
                            overflow: TextOverflow.clip,
                            maxLines: 2,
                          ),
                        Text(
                          "${info.enCity}",
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                        ),
                        Text(
                          "${info.enPrefectures} ${info.zip} ",
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                        ),
                        Text(
                          counrty,
                          style: Theme.of(context).textTheme.titleMedium,
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
      ),
    );
  }
}
