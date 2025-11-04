import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemCubit extends Cubit<ThemeMode> {
  ThemCubit() : super(ThemeMode.system) {
    _loadTheme();
  }

  static const String _key = "isdark";
  Future<void> _loadTheme() async {
    final box = GetStorage();
    // final prefs = await SharedPreferences.getInstance();
    final isDark = box.read(_key); //prefs.getBool(_key);

    if (isDark == null) {
      emit(ThemeMode.system);
    } else {
      emit(isDark ? ThemeMode.dark : ThemeMode.light);
    }
  }

  Future<void> toggleTheme() async {
    // final preferences = await SharedPreferences.getInstance();
    final box = GetStorage();
    if (state == ThemeMode.light) {
      emit(ThemeMode.dark);
      await box.write(_key, true); // preferences.setBool(_key, true);
    } else {
      emit(ThemeMode.light);
      await box.write(_key, false); //preferences.setBool(_key, false);
    }
  }
}
