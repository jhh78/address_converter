// 주소양식 : マンションの名前, 部屋番号, 番地, 市町村, 都道府県, 郵便番号, 国名
import 'package:english_address_converter/widgets/search_result_text_block.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ResultInfo extends StatelessWidget {
  final dynamic info;
  final String lang;
  final String koreaName = "Republic of Korea";
  final String japanName = "Japan";

  const ResultInfo({Key? key, required this.info, required this.lang})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.searchResultTitle),
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
                            label: "Town",
                            value: info.enStreet.toString(),
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
                            value: lang == 'ko' ? koreaName : japanName,
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
                          Text(
                            "${info.enStreet}",
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
                            lang == 'ko' ? koreaName : japanName,
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
        ));
  }
}
