import 'package:flutter/material.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(controller!);

    controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    var txt =
        'InstaStores is a place where you can find all sorts of available stores under the categories that are available in Instagram Platform. The problem I encountered while trying to shop a certain product was how do i look for it, searching for one product does not show on what stores they are available at, for instance if i wanna buy a shirt just searching for it or searching something like Mens Fashion wont show the reputed stores/id list. So to make things easier I created this application. Hope you guys will like it !';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          FadeTransition(
            opacity: _animation!,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              //color: Colors.black.withOpacity(0.1),
              child: Text(
                txt,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Ubuntu',
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Text(
          'Insta Stores',
          textAlign: TextAlign.end,
          style: TextStyle(
            fontFamily: 'Grand',
            fontSize: 36,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
