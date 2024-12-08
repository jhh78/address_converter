import 'dart:developer';
import 'package:english_address_converter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SystemProvider extends GetxService {
  Rx<ThemeMode> themeMode = ThemeMode.light.obs;
  late Box systemBox;

  @override
  void onInit() {
    super.onInit();
    log('SystemProvider initialized');

    _loadBox().then((_) {
      _loadTheme();
    });
  }

  Future<void> _loadBox() async {
    systemBox = await Hive.openBox(LOCAL_BOX);
  }

  void _loadTheme() async {
    final int? themeModeIndex = systemBox.get(THEME_DATA);
    log('systemData: $themeModeIndex');
    if (themeModeIndex != null) {
      themeMode.value = ThemeMode.values[themeModeIndex];
    } else {
      themeMode.value = ThemeMode.light;
    }

    log('themeMode: ${themeMode.value}');
  }

  void toggleTheme() {
    if (themeMode.value == ThemeMode.light) {
      themeMode.value = ThemeMode.dark;
    } else {
      themeMode.value = ThemeMode.light;
    }
    log('toggleTheme: ${themeMode.value}');
    _saveTheme();
  }

  void _saveTheme() async {
    systemBox.put(THEME_DATA, themeMode.value.index);
  }
}
