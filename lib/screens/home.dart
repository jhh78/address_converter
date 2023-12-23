import 'package:flutter/material.dart';
import 'package:flutter_core/models/db.dart';

//TODO:::핸드폰에 데이터 저장하기
//TODO:::핸드폰에 데이터 불러오기
//TODO:::핸드폰에 데이터 삭제하기
//TODO:::API 연동하기
//TODO:::UI만들기
//TODO:::광고달기
//TODO:::인앱 결제 넣기

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> jsonList = [];
  DBModel dbModel = DBModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jsonList = dbModel.doSelect();
  }

  @override
  Widget build(BuildContext context) {
    print(jsonList);
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '入力した住所を英語へ変換します。',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '変換する住所を入力してください。',
            ),
            textInputAction: TextInputAction.search,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: jsonList.length,
              itemBuilder: (context, builder) {
                return ListTile(
                  title: Text(jsonList[builder].toString()),
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
      )),
    );
  }
}
