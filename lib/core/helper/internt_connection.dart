import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class TinterneteConnction {
  TinterneteConnction._();
  static final instance = TinterneteConnction._();
  Future<bool> isConnected() async {
    return await InternetConnection().hasInternetAccess;
  }

  final subscription = InternetConnection().onStatusChange;
}
