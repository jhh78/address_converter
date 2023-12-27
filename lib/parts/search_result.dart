import 'package:flutter/material.dart';
import 'package:flutter_core/db/jp_address.dart';
import 'package:flutter_core/models/app_config.dart';

class SearchResult extends StatelessWidget {
  final List<JpAddress> addressList;

  const SearchResult({super.key, required this.addressList});

  @override
  Widget build(BuildContext context) {
    if (addressList.isEmpty) {
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
      itemCount: addressList.length,
      itemBuilder: (context, builder) {
        return ListTile(
          title: Text(addressList[builder].jp ?? 'na'),
          onTap: () {
            // 주소양식 : マンションの名前, 部屋番号, 番地, 市町村, 都道府県, 郵便番号, 国名
            // TODO ::: 탭 했을때 팝업으로 우편번호 최종 완성본이 보이도록 하기
            final String zipcode =
                '${addressList[builder].zip!.substring(0, 3)}-${addressList[builder].zip!.substring(3)}';
            final String addr =
                '「マンションの名前」「部屋番号」「番地」${addressList[builder].enTown}、${addressList[builder].enCity}、${addressList[builder].enPrefectures}、$zipcode、Japan';
            debugPrint(addr);
          },
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
