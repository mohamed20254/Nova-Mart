import 'package:get_storage/get_storage.dart';

class IsFirstTime {
  static final box = GetStorage();
  static const String _key = "isfirsttime";
  static bool getFirstTime() {
    return box.read(_key) ?? true;
  }

  static void setFirstTime(bool value) {
    box.write(_key, value);
  }
}
