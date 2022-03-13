import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instastores/controllers/data_controller.dart';
import 'package:instastores/views/add_store.dart';
import 'package:instastores/widgets/store_widget.dart';
import 'package:get/get.dart';

class StoreListScreen extends StatefulWidget {
  const StoreListScreen({Key? key}) : super(key: key);

  @override
  State<StoreListScreen> createState() => _StoreListScreenState();
}

class _StoreListScreenState extends State<StoreListScreen> {
  final authUser = FirebaseAuth.instance.currentUser;
  final DataController data = Get.find();
  @override
  Widget build(BuildContext context) {
    var gotData = Get.arguments;

    return WillPopScope(
      onWillPop: () async {
        data.cleanwhenWillpop();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            authUser!.email == 'raosao61@gmail.com'
                ? IconButton(
                    onPressed: () {
                      Get.to(() => AddStore(),
                          arguments: [gotData[0], gotData[1]]);
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.black,
                    ))
                : Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: CircleAvatar(
                      maxRadius: 14,
                      backgroundImage: NetworkImage(authUser!.photoURL!),
                    ),
                  )
          ],
          leading: IconButton(
              onPressed: () {
                data.back();
              },
              icon: Icon(Icons.arrow_back)),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0.7,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 6.0, left: 0),
            child: Text(
              "${gotData[1]} Stores",
              style: TextStyle(
                  fontFamily: 'Spartan',
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, top: 10),
              child: Text(
                "${data.StoreCount} Stores Available",
                style: TextStyle(
                  //  shadows: [Shadow(color: Colors.black, offset: Offset(0, -5))],
                  fontFamily: "Spartan",
                  color: Colors.black,
                  fontSize: 22,
                  //decoration: TextDecoration.underline,
                  // decorationColor: Color(0xff13a4f8),
                  decorationThickness: 3,
                  //  decorationStyle: TextDecorationStyle.dashed,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Container(
                height: 1,
                color: Colors.black.withOpacity(0.09),
              ),
            ),
            Expanded(
              child: GetBuilder<DataController>(
                builder: (controller) => data.filtered.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(15),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          //  childAspectRatio: 1 / 1.6,
                          crossAxisSpacing: 10,

                          mainAxisExtent: 170,
                        ),
                        itemCount: data.filtered.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.only(bottom: 14.0),
                              child: StoreWidget(
                                id: data.filtered[index].id,
                                imageUrl: data.filtered[index].imageUrl,
                                linkUrl: data.filtered[index].storeUrl,
                                name: data.filtered[index].name,
                              ));
                        }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
