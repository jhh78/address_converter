import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_core/core/logo.dart';
import 'package:flutter_core/home.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogoPage = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      setState(() {
        isLogoPage = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: WillPopScope(
          onWillPop: () async => false,
          child: isLogoPage ? const LogoPage() : const Home()),
    );
  }
}
