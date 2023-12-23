import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_core/screens/home.dart';
import 'package:flutter_core/screens/logo.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
