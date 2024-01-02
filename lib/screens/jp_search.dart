import 'package:english_address_converter/widgets/search_result.dart';
import 'package:flutter/material.dart';
import 'package:english_address_converter/models/jp_address.dart';
import 'package:english_address_converter/services/search.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JPSearch extends StatefulWidget {
  const JPSearch({super.key});

  @override
  JPSearchState createState() => JPSearchState();
}

class JPSearchState extends State<JPSearch> {
  List<JPAddress> addressList = [];
  SearchModel searchModel = SearchModel();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            decoration: InputDecoration(
              alignLabelWithHint: true,
              border: const OutlineInputBorder(),
              labelText: AppLocalizations.of(context)!.jpSearchHint,
            ),
            onSubmitted: (String searchWord) {
              debugPrint(
                  '???????????????????????????????????????? $searchWord');
              searchModel.initDb().then((_) {
                searchModel.searchJapanAddress(searchWord).then((value) {
                  debugPrint('???????????????????????????????????????? $value');
                  setState(() {
                    addressList = value;
                  });
                });
              });
            },
            textInputAction: TextInputAction.search,
          ),
        ),
        Expanded(
          child: SearchResult(
            addressInfo: addressList,
            lang: 'ja',
          ),
        )
      ],
    );
  }
}
