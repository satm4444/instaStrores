import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instastores/controllers/auth_controller.dart';
import 'package:instastores/views/homescreen.dart';
import 'package:instastores/views/login_screen.dart';
import 'package:get/get.dart';

class DeciderScreen extends StatelessWidget {
  final SignInAuth signInAuth = Get.put(SignInAuth());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return HomeScreen();
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Something error happened"),
            );
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
