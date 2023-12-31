import 'package:flutter/material.dart';
import 'package:flutter_core/db/kr_address.dart';
import 'package:flutter_core/models/search.dart';
import 'package:flutter_core/parts/search_result.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class KRSearch extends StatefulWidget {
  const KRSearch({super.key});

  @override
  KRSearchState createState() => KRSearchState();
}

class KRSearchState extends State<KRSearch> {
  List<KRAddress> addressList = [];
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
              labelText: AppLocalizations.of(context)!.krSearchHint,
            ),
            onSubmitted: (String searchWord) {
              debugPrint(
                  '???????????????????????????????????????? $searchWord');
              searchModel.initDb().then((_) {
                searchModel.searchKoreaAddress(searchWord).then((value) {
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
            lang: 'ko',
          ),
        )
      ],
    );
  }
}
