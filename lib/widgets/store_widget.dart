import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instastores/controllers/data_controller.dart';
import 'package:instastores/views/store_editor.dart';
import 'package:instastores/views/store_web_view.dart';

class StoreWidget extends StatefulWidget {
  final String id;
  final String name;
  final String imageUrl;
  final String linkUrl;

  const StoreWidget(
      {Key? key,
      required this.id,
      required this.name,
      required this.imageUrl,
      required this.linkUrl})
      : super(key: key);

  @override
  State<StoreWidget> createState() => _StoreWidgetState();
}

class _StoreWidgetState extends State<StoreWidget> {
  final currentUser = FirebaseAuth.instance.currentUser;

  final DataController dataController = Get.find();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Get.to(() => StoreWebView(), arguments: widget.linkUrl);
      },
      child: Stack(
        children: [
          Container(
            // height: size.height * 0.18,
            decoration: BoxDecoration(
              //   color: Colors.red,
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: Colors.black.withOpacity(0.3)),
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 9.6),
                  child: Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        //   color: Colors.blue,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      //elevation: 2.4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/loading2.gif',
                          image: widget.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5),
                  child: Text(
                    widget.name,
                    // maxLines: 1,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,

                      //  letterSpacing: 0.5,
                      fontFamily: "Barlow",
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Color(0xff13a4f8).withOpacity(0.8),
                    ),
                    height: 25,
                    child: Center(
                      child: Text(
                        "Open",
                        style: TextStyle(
                          fontFamily: "Ubuntu",
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          currentUser!.email == 'raosao61@gmail.com'
              ? Positioned(
                  left: 5,
                  top: 75,
                  child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            dataController.deletStore(widget.id);
                          },
                          icon: Icon(
                            Icons.delete,
                            size: 14,
                          ),
                        ),
                      )),
                )
              : SizedBox(),
          currentUser!.email == 'raosao61@gmail.com'
              ? Positioned(
                  left: 75,
                  top: 75,
                  child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            Get.to(() => StoreEditor(), arguments: widget.id);
                          },
                          icon: Icon(
                            Icons.edit,
                            size: 14,
                          ),
                        ),
                      )),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
