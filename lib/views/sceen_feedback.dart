import 'package:flutter/material.dart';
import 'package:instastores/controllers/data_controller.dart';
import 'package:get/get.dart';
import 'package:instastores/views/feedback_tiles.dart';

class FeedBackList extends StatefulWidget {
  const FeedBackList({Key? key}) : super(key: key);

  @override
  State<FeedBackList> createState() => _FeedBackListState();
}

class _FeedBackListState extends State<FeedBackList> {
  final DataController dataController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Feedbacks",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<DataController>(
        builder: (controller) => dataController.feedbackItems.isEmpty
            ? Center(
                child: Text("No feedbacks now !"),
              )
            : ListView.builder(
                itemCount: dataController.feedbackItems.length,
                itemBuilder: (context, index) {
                  return FeedbackTile(
                      mail: dataController.feedbackItems[index].userMail,
                      feed: dataController.feedbackItems[index].userFeedback);
                }),
      ),
    );
  }
}
