import 'package:ecomerc_app_with_admin/app.dart';
import 'package:ecomerc_app_with_admin/core/di/injection_container.dart' as di;
import 'package:ecomerc_app_with_admin/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  //*widget Bindung
  WidgetsFlutterBinding.ensureInitialized();

  //* init localStorage
  await GetStorage.init();
  //*  initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //* initialize
  await ScreenUtil.ensureScreenSize();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await di.init();
  runApp(const MyApp());
  // FirebaseAuth.instance.userChanges().listen((event) => print(event!.email.toString()) );
  await FirebaseAuth.instance.setLanguageCode("en");

  // print("$user ===================================================");
}
