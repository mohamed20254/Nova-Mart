import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationCubit extends Cubit<String> {
  LocalizationCubit() : super("en") {
    _loade();
  }
  final String _key = "loclization";

  Future<void> _loade() async {
    final pref = await SharedPreferences.getInstance();
    final String local = pref.getString(_key) ?? "en";
    emit(local);
  }

  Future<void> toogale(String lang) async {
    final pref = await SharedPreferences.getInstance();
    emit(lang);
    pref.setString(_key, lang);
  }
}
