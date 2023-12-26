import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_core/screens/home.dart';
import 'package:flutter_core/screens/logo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dbDir = await getDatabasesPath();
  var dbPath = join(dbDir, "app.db");

  // TODO : db 파일이 없을 경우에만 복사하도록 수정

  ByteData data = await rootBundle.load("assets/app.db");
  List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  await File(dbPath).writeAsBytes(bytes);

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLogo = true;

  @override
  void initState() {
    super.initState();
    // 어플리케이션 초기화 코드 넣을것
    Timer(const Duration(seconds: 3), () {
      setState(() {
        _isLogo = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: _isLogo ? const LogoScreen() : const HomeScreen());
  }
}
