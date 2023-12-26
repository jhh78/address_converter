import 'package:flutter/material.dart';
import 'package:flutter_core/db/jp_address.dart';
import 'package:flutter_core/models/ja_search.dart';

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
            decoration: const InputDecoration(
              alignLabelWithHint: true,
              border: OutlineInputBorder(),
              labelText: '例）東京都渋谷区',
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
          child: ListView.separated(
            itemCount: addressList.length,
            itemBuilder: (context, builder) {
              return Column(children: [
                ListTile(
                  subtitle: Text(addressList[builder].jp ?? '-1'),
                  title: Text(addressList[builder].en ?? '-1'),
                ),
              ]);
            },
            separatorBuilder: (context, builder) {
              return const Divider(
                height: 2,
              );
            },
          ),
        )
      ],
    );
  }
}
