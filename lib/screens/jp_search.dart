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
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: TextField(
              decoration: InputDecoration(
                alignLabelWithHint: true,
                border: const OutlineInputBorder(),
                labelText: AppLocalizations.of(context)!.jpSearchHint,
              ),
              onSubmitted: (String searchWord) async {
                setState(() {
                  _isProcessing = true;
                });
                List<JPAddress> lists =
                    await searchModel.searchJapanAddress(searchWord);
                setState(() {
                  addressList = lists;
                  _isProcessing = false;
                });
              },
              textInputAction: TextInputAction.search,
            ),
          ),
          _isProcessing
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SearchResult(
                  addressInfo: addressList,
                  lang: 'ja',
                )
        ],
      ),
    );
  }
}
