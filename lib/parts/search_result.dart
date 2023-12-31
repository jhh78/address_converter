import 'package:flutter/material.dart';
import 'package:flutter_core/db/jp_address.dart';
import 'package:flutter_core/models/app_config.dart';

class SearchResult extends StatefulWidget {
  final List<JpAddress> addressList;

  const SearchResult({super.key, required this.addressList});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  // 주소양식 : マンションの名前, 部屋番号, 番地, 市町村, 都道府県, 郵便番号, 国名
  void _showDialog(BuildContext context, JpAddress addressInfo) {
    final String zipcode =
        '${addressInfo.zip!.substring(0, 3)}-${addressInfo.zip!.substring(3)}';

    AlertDialog dialog = AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppConfig.addressDialogHintDescriptionA,
            style: const TextStyle(fontSize: 18, color: Colors.blueAccent),
          ),
          Text(
            AppConfig.addressDialogHintDescriptionB,
            style: const TextStyle(fontSize: 18, color: Colors.blueAccent),
          ),
          Text(addressInfo.enTown.toString(),
              style: const TextStyle(fontSize: 18)),
          Text(addressInfo.enCity.toString(),
              style: const TextStyle(fontSize: 18)),
          Text(addressInfo.enPrefectures.toString(),
              style: const TextStyle(fontSize: 18)),
          Text(zipcode, style: const TextStyle(fontSize: 18)),
          Text(AppConfig.countryName, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 15),
          Text(AppConfig.addressDialogHintDescriptionC,
              style: const TextStyle(fontSize: 12, color: Colors.redAccent)),
          Text(AppConfig.addressDialogHintDescriptionD,
              style: const TextStyle(fontSize: 12, color: Colors.redAccent)),
          Text(AppConfig.addressDialogHintDescriptionE,
              style: const TextStyle(fontSize: 12, color: Colors.redAccent)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(AppConfig.addressDialogClose),
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.addressList.isEmpty) {
      return Center(
        child: Text(
          AppConfig.noSearchResult,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return ListView.separated(
      itemCount: widget.addressList.length,
      itemBuilder: (context, builder) {
        JpAddress addressInfo = widget.addressList[builder];

        return ListTile(
          title: Text(addressInfo.jp ?? 'na'),
          onTap: () => _showDialog(context, addressInfo),
        );
      },
      separatorBuilder: (context, builder) {
        return const Divider(
          height: 2,
        );
      },
    );
  }
}
