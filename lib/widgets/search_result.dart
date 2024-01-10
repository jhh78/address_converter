import 'package:english_address_converter/widgets/search_result_info.dart';
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
                  builder: (context) => ResultInfo(
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
