import 'package:english_address_converter/widgets/search_result_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/route_manager.dart';

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
      return Expanded(
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
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: widget.addressInfo.length,
        itemBuilder: (context, index) {
          dynamic addressInfo = widget.addressInfo[index];
          return Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: ListTile(
              title: Text(addressInfo.address1 ?? 'na'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Get.to(
                  () => const ResultInfo(),
                  arguments: {
                    'info': addressInfo,
                    'lang': widget.lang,
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
