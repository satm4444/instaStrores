import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StoreWebView extends StatefulWidget {
  const StoreWebView({Key? key}) : super(key: key);

  @override
  State<StoreWebView> createState() => _StoreWebViewState();
}

class _StoreWebViewState extends State<StoreWebView> {
  final tooltipController = JustTheController();
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      tooltipController.showTooltip(immediately: false);
    });
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  final authUser = FirebaseAuth.instance.currentUser;
  var storeLink = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              maxRadius: 14,
              backgroundImage: NetworkImage(authUser!.photoURL!),
            ),
          )
        ],

        elevation: 0.7,
        centerTitle: true,
        backgroundColor: Colors.white,
        //backgroundColor: Color(0xfff2f2f4),
        title: Padding(
          padding: const EdgeInsets.only(top: 6.0, left: 0),
          child: Text(
            'Insta Stores',
            style: TextStyle(
              fontFamily: 'Grand',
              fontSize: 36,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: WebView(
        initialUrl: storeLink,
        javascriptMode: JavascriptMode.unrestricted,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          tooltip: 'Open Instagram here',
          child: JustTheTooltip(
            controller: tooltipController,
            content: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Open in Instagram',
              ),
            ),
            child: FaIcon(
              FontAwesomeIcons.instagram,
              size: 32,
            ),
          ),
          onPressed: () {
            launch(storeLink, forceWebView: false);
          }),
    );
  }
}
