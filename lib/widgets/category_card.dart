import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instastores/controllers/data_controller.dart';
import 'package:instastores/controllers/dialog_loadingbox.dart';
import 'package:instastores/views/category_editor.dart';

import 'package:instastores/views/store_list_screen.dart';

class CategoryCard extends StatefulWidget {
  final String id;
  final String categoryName;
  final String imageUrl;
  const CategoryCard(
      {Key? key,
      required this.id,
      required this.categoryName,
      required this.imageUrl})
      : super(key: key);

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  final DataController dataController = Get.find();

  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        CommonDialog.showLoading();

        dataController.findList(dataController.storeItems, widget.id);
        dataController.getStoreNumber();
        CommonDialog.hideLoading();
        Get.to(
          () => StoreListScreen(),
          arguments: [widget.id, widget.categoryName],
        );
      }),
      child: Stack(
        children: [
          Container(
            // height: MediaQuery.of(context).size.height * 0.17,
            decoration: BoxDecoration(
                //  color: Colors.red,
                borderRadius: BorderRadius.circular(3),
                border: Border.all(
                    color: Colors.black.withOpacity(0.25), width: 1)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    //   color: Colors.blue,

                    height: 110,
                    width: double.infinity,
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading2.gif',
                      image: widget.imageUrl,
                      fit: BoxFit.cover,
                    ),
                    // child: Image.network(
                    //   widget.imageUrl,
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 0),
                  child: Text(
                    widget.categoryName,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      //  letterSpacing: 0.5,
                      fontFamily: "Barlow",
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
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
                            dataController.deletCategory(widget.id);
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
                            Get.to(() => CategoryEditor(),
                                arguments: widget.id);
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
