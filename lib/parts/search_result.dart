import 'package:flutter/material.dart';
import 'package:flutter_core/db/jp_address.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchResult extends StatefulWidget {
  final List<dynamic> addressInfo;
  final String lang;

  const SearchResult({Key? key, required this.addressInfo, required this.lang})
      : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  final String koreaName = "Republic of Korea";
  final String japanName = "Japan";

  // 주소양식 : マンションの名前, 部屋番号, 番地, 市町村, 都道府県, 郵便番号, 国名
  void _showDialog(BuildContext context, dynamic addressInfo) {
    final String zipcode =
        '${addressInfo.zip!.substring(0, 3)}-${addressInfo.zip!.substring(3)}';

    AlertDialog dialog = AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.addressDialogHintDescriptionA,
            style: const TextStyle(fontSize: 18, color: Colors.blueAccent),
          ),
          Text(
            AppLocalizations.of(context)!.addressDialogHintDescriptionB,
            style: const TextStyle(fontSize: 18, color: Colors.blueAccent),
          ),
          if (widget.lang == 'ko')
            Text(
              addressInfo.enStreet.toString(),
              style: const TextStyle(fontSize: 18),
            ),
          if (addressInfo.enTown.toString().isNotEmpty)
            Text(addressInfo.enTown.toString(),
                style: const TextStyle(fontSize: 18)),
          Text(addressInfo.enCity.toString(),
              style: const TextStyle(fontSize: 18)),
          Text(addressInfo.enPrefectures.toString(),
              style: const TextStyle(fontSize: 18)),
          Text(zipcode, style: const TextStyle(fontSize: 18)),
          Text(widget.lang == 'ko' ? koreaName : japanName,
              style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 15),
          Text(AppLocalizations.of(context)!.addressDialogHintDescriptionC,
              style: const TextStyle(fontSize: 12, color: Colors.redAccent)),
          Text(AppLocalizations.of(context)!.addressDialogHintDescriptionD,
              style: const TextStyle(fontSize: 12, color: Colors.redAccent)),
          Text(AppLocalizations.of(context)!.addressDialogHintDescriptionE,
              style: const TextStyle(fontSize: 12, color: Colors.redAccent)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context)!.addressDialogClose),
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
    if (widget.addressInfo.isEmpty) {
      return Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.noSearchResult1,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.noSearchResult2,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      itemCount: widget.addressInfo.length,
      itemBuilder: (context, builder) {
        dynamic addressInfo = widget.addressInfo[builder];
        return ListTile(
          title: Text(addressInfo.address ?? 'na'),
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
