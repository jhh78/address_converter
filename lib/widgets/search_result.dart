import 'package:flutter/material.dart';
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultScreen(
                    info: addressInfo,
                    lang: widget.lang,
                  ),
                ),
              );
            });
      },
      separatorBuilder: (context, builder) {
        return const Divider(
          height: 2,
        );
      },
    );
  }
}

// 주소양식 : マンションの名前, 部屋番号, 番地, 市町村, 都道府県, 郵便番号, 国名
class ResultScreen extends StatelessWidget {
  final dynamic info;
  final String lang;
  final String koreaName = "Republic of Korea";
  final String japanName = "Japan";

  const ResultScreen({Key? key, required this.info, required this.lang})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.searchResultTitle),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.addressDialogHintDescriptionA,
                style: const TextStyle(fontSize: 18, color: Colors.blueAccent),
              ),
              Text(
                AppLocalizations.of(context)!.addressDialogHintDescriptionB,
                style: const TextStyle(fontSize: 18, color: Colors.blueAccent),
              ),
              if (lang == 'ko')
                Text(
                  info.enStreet.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
              if (info.enTown.toString().isNotEmpty)
                Text(info.enTown.toString(),
                    style: const TextStyle(fontSize: 18)),
              Text(info.enCity.toString(),
                  style: const TextStyle(fontSize: 18)),
              Text(info.enPrefectures.toString(),
                  style: const TextStyle(fontSize: 18)),
              Text(info.zip.toString(), style: const TextStyle(fontSize: 18)),
              Text(lang == 'ko' ? koreaName : japanName,
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 15),
              Text(AppLocalizations.of(context)!.addressDialogHintDescriptionC,
                  style:
                      const TextStyle(fontSize: 12, color: Colors.redAccent)),
              Text(AppLocalizations.of(context)!.addressDialogHintDescriptionD,
                  style:
                      const TextStyle(fontSize: 12, color: Colors.redAccent)),
              Text(AppLocalizations.of(context)!.addressDialogHintDescriptionE,
                  style:
                      const TextStyle(fontSize: 12, color: Colors.redAccent)),
            ],
          ),
        ));
  }
}
