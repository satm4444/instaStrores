import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instastores/controllers/auth_controller.dart';
import 'package:instastores/views/decider_screen.dart';

import 'package:get/get.dart';
import 'package:instastores/views/homescreen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String? mail;
  const MyApp({Key? key, this.mail}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InstaStores',
      home: mail == null ? DeciderScreen() : HomeScreen(),
    );
  }
}
