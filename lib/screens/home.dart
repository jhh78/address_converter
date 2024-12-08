import 'dart:developer';

import 'package:english_address_converter/providers/system.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BannerAd? _bannerAd;
  SystemProvider systemProvider = Get.put(SystemProvider());

  @override
  void dispose() {
    super.dispose();
    _bannerAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "addressConverter".tr,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
      body: Text("sfs"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          systemProvider.toggleTheme();
        },
        child: const Icon(Icons.brightness_4),
      ),
    );
  }
}
