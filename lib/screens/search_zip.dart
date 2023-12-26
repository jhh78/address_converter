import 'package:flutter/material.dart';
import 'package:flutter_core/db/jp_address.dart';
import 'package:flutter_core/models/ja_search.dart';

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
            decoration: const InputDecoration(
              alignLabelWithHint: true,
              border: OutlineInputBorder(),
              labelText: '例）1638001',
            ),
            onSubmitted: (String searchWord) {
              debugPrint(
                  '???????????????????????????????????????? $searchWord');
            },
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.search,
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: addressList.length,
            itemBuilder: (context, builder) {
              return ListTile(
                title: Text(addressList[builder].toString()),
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
    );
  }
}
