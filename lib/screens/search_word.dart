import 'package:flutter/material.dart';
import 'package:flutter_core/db/jp_address.dart';
import 'package:flutter_core/models/app_config.dart';
import 'package:flutter_core/models/ja_search.dart';
import 'package:flutter_core/parts/search_result.dart';

class SearchWord extends StatefulWidget {
  const SearchWord({super.key});

  @override
  SearchWordState createState() => SearchWordState();
}

class SearchWordState extends State<SearchWord> {
  List<JpAddress> addressList = [];
  JaSearchModel jaModel = JaSearchModel();

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
              labelText: AppConfig.addressSearchHint,
            ),
            onSubmitted: (String searchWord) {
              debugPrint(
                  '???????????????????????????????????????? $searchWord');
              jaModel.initDb().then((_) {
                jaModel.searchFromUserInput(searchWord).then((value) {
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
          child: SearchResult(addressList: addressList),
        )
      ],
    );
  }
}
