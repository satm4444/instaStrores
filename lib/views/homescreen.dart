import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:instastores/controllers/auth_controller.dart';
import 'package:instastores/controllers/data_controller.dart';
import 'package:instastores/views/about_us_screen.dart';
import 'package:instastores/views/add_category.dart';
import 'package:instastores/views/feedback_screen.dart';
import 'package:instastores/views/sceen_feedback.dart';
import 'package:instastores/widgets/list_builder.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:share_plus/share_plus.dart';

import 'package:instastores/widgets/category_card.dart';

import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BannerAd _bannerAd;
  bool isLoading = false;

  @override
  void initState() {
    _initbannerAd();
    super.initState();
  }

  void _initbannerAd() {
    _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: 'ca-app-pub-6180176865412768/3152051994',
        listener: BannerAdListener(onAdLoaded: (_) {
          setState(() {
            isLoading = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          print('Failed to load banner Ad${error.message}');
          isLoading = false;

          ad.dispose();
        }),
        request: AdRequest());
    _bannerAd.load();
  }

  final DataController data = Get.put(DataController());
  final authUser = FirebaseAuth.instance.currentUser;
  final SignInAuth auth = Get.find();

  @override
  Widget build(BuildContext context) {
    //  var number = '9868768895';
    var devicesize = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: isLoading
          ? Container(
              height: _bannerAd.size.height.toDouble(),
              width: _bannerAd.size.width.toDouble(),
              child: AdWidget(ad: _bannerAd),
            )
          : SizedBox(),
      //  backgroundColor: Color(0xfff2f2f4),
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          authUser!.email == 'raosao61@gmail.com'
              ? Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.to(
                            () => FeedBackList(),
                          );
                        },
                        icon: Icon(
                          Icons.feed_outlined,
                          color: Colors.black,
                        )),
                    IconButton(
                        onPressed: () {
                          Get.to(
                            () => AddCategory(),
                          );
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.black,
                        )),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: CircleAvatar(
                    maxRadius: 14,
                    backgroundImage: NetworkImage(authUser!.photoURL!),
                  ),
                )
        ],
        leading: Padding(
          padding: const EdgeInsets.all(15.0),
          child: PopupMenuButton(
              child: SvgPicture.asset("assets/images/menu.svg"),
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: TextButton.icon(
                        onPressed: () async {
                          launch('tel:9868768895');
                        },
                        icon: Icon(
                          Icons.call,
                          color: Colors.black,
                        ),
                        label: Text(
                          "Contact Us",
                          style: TextStyle(
                              fontFamily: 'Ubuntu',
                              color: Colors.black,
                              fontSize: 15),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      child: TextButton.icon(
                        onPressed: () {
                          Get.back();
                          Get.to(() => AboutUsScreen());
                        },
                        icon: Icon(
                          Icons.info,
                          color: Colors.black,
                        ),
                        label: Text(
                          "About Us",
                          style: TextStyle(
                              fontFamily: 'Ubuntu',
                              color: Colors.black,
                              fontSize: 15),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      child: TextButton.icon(
                        onPressed: () {
                          Get.back();
                          Get.to(() => FeedBackScreen());
                        },
                        icon: Icon(
                          Icons.note_alt_outlined,
                          color: Colors.black,
                        ),
                        label: Text(
                          "Give Feedback",
                          style: TextStyle(
                              fontFamily: 'Ubuntu',
                              color: Colors.black,
                              fontSize: 15),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      child: TextButton.icon(
                        onPressed: () {
                          Share.share(
                              'Hi,Download this app from https://play.google.com/store/apps/details?id=com.kitespace.instastores');
                        },
                        icon: Icon(
                          Icons.share,
                          color: Colors.black,
                        ),
                        label: Text(
                          "Share app",
                          style: TextStyle(
                              fontFamily: 'Ubuntu',
                              color: Colors.black,
                              fontSize: 15),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {},
                      child: TextButton.icon(
                        onPressed: () async {
                          Get.back();
                          auth.googleSignOut();
                        },
                        icon: Icon(
                          Icons.logout,
                          color: Colors.black,
                        ),
                        label: Text(
                          "Logout",
                          style: TextStyle(
                              fontFamily: 'Ubuntu',
                              color: Colors.black,
                              fontSize: 15),
                        ),
                      ),
                    )
                  ]),
        ),

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 9.0),
            //   child: Container(height: 100, child: ListTileBuilder()),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 10),
              child: Text(
                "Categories",
                style: TextStyle(
                  //  shadows: [Shadow(color: Colors.black, offset: Offset(0, -5))],
                  fontFamily: "Spartan",
                  color: Colors.black,
                  fontSize: 26,
                  //decoration: TextDecoration.underline,
                  // decorationColor: Color(0xff13a4f8),
                  decorationThickness: 3,
                  //  decorationStyle: TextDecorationStyle.dashed,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),

            ///======SHOW CATEGORY DATA COMING FROM FIRESTORE===///

            Container(
              //color: Colors.green,
              height: devicesize.height * 0.7,
              width: double.infinity,
              child: GetBuilder<DataController>(
                builder: ((controller) => data.items.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      )
                    : GridView.builder(
                        physics: ClampingScrollPhysics(),
                        padding: EdgeInsets.all(15.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisExtent: 160,
                          //childAspectRatio: 1 / 1.4,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: data.items.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.only(bottom: 14.0),
                              child: CategoryCard(
                                id: data.items[index].id,
                                categoryName: data.items[index].name,
                                imageUrl: data.items[index].imageUrl,
                              ));
                        })),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
