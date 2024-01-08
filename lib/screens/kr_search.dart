import 'package:english_address_converter/widgets/search_result.dart';
import 'package:flutter/material.dart';
import 'package:english_address_converter/models/kr_address.dart';
import 'package:english_address_converter/services/search.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class KRSearch extends StatefulWidget {
  const KRSearch({super.key});

  @override
  KRSearchState createState() => KRSearchState();
}

class KRSearchState extends State<KRSearch> {
  List<KRAddress> addressList = [];
  SearchModel searchModel = SearchModel();
  bool _isProcessing = false;

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
              setState(() {
                _isProcessing = true;
              });
              searchModel.initDb().then((_) {
                searchModel.searchKoreaAddress(searchWord).then((value) {
                  debugPrint('???????????????????????????????????????? $value');
                  setState(() {
                    addressList = value;
                    _isProcessing = false;
                  });
                });
              });
            },
            textInputAction: TextInputAction.search,
          ),
        ),
        Expanded(
          child: _isProcessing
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SearchResult(
                  addressInfo: addressList,
                  lang: 'ko',
                ),
        )
      ],
    );
  }
}
