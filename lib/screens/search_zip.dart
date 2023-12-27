import 'package:flutter/material.dart';
import 'package:flutter_core/db/jp_address.dart';
import 'package:flutter_core/models/app_config.dart';
import 'package:flutter_core/models/ja_search.dart';
import 'package:flutter_core/parts/search_result.dart';

class SearchZip extends StatefulWidget {
  const SearchZip({super.key});

  @override
  SearchZipState createState() => SearchZipState();
}

class SearchZipState extends State<SearchZip> {
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
              labelText: AppConfig.zipCodeSearchHint,
            ),
            onSubmitted: (String searchWord) {
              debugPrint(
                  '???????????????????????????????????????? $searchWord');
              jaModel.initDb().then((_) {
                jaModel.searchFromZipCode(searchWord).then((value) {
                  debugPrint('???????????????????????????????????????? $value');
                  setState(() {
                    addressList = value;
                  });
                });
              });
            },
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.search,
          ),
        ),
        Expanded(
          child: Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: SearchResult(addressList: addressList)),
        )
      ],
    );
  }
}
