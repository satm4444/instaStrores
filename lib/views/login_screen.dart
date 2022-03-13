import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:instastores/controllers/auth_controller.dart';
import 'package:instastores/views/decider_screen.dart';
import 'package:instastores/views/homescreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final SignInAuth signIn = Get.find();

  // double _googleOpacity = 0;
  // double _facebookOpacity = 0;
  // double _instaOpacity = 0;

  // @override
  // void initState() {
  //   Future.delayed(Duration(milliseconds: 400), () {
  //     setState(() {
  //       _googleOpacity = 1;
  //     });
  //   });
  //   Future.delayed(Duration(milliseconds: 800), () {
  //     setState(() {
  //       _facebookOpacity = 1;
  //     });
  //   });
  //   Future.delayed(Duration(milliseconds: 1200), () {
  //     setState(() {
  //       _instaOpacity = 1;
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    var devicesize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
          child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: devicesize.height * 0.5,
              child: Column(
                children: [
                  SizedBox(
                    height: devicesize.height * 0.22,
                  ),
                  Text(
                    "Insta Stores",
                    style: TextStyle(
                        fontFamily: 'Grand',
                        fontSize: 66,
                        //  fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  Text(
                    "All your Instagram stores at one place.",
                    style: TextStyle(
                        fontFamily: 'Fredoka',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(0.3)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                // color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70,
                      ),
                      Text(
                        "CONTINUE WITH ",
                        style: TextStyle(
                          fontFamily: "Fredoka",
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          signIn.googleLogin();
                        },
                        child: Container(
                          height: 75,
                          width: 75,
                          //   color: Colors.grey,
                          child: Image.asset('assets/images/google.jpg'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
