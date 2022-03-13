// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonDialog {
  //////======FOR LOADING====//////
  static showLoading({String title = "Loading..."}) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: 50,
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(title),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

/////=====FOR HIDING LOADING====//
  static hideLoading() {
    Get.back();
  }

////=====FOR ERROR DIALOG====////
  static showErrorDialog(
      {String title = "Oops error occured",
      String description = "Something went wrong"}) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Container(
            height: 90,
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (Get.isDialogOpen!) {
                        Get.back();
                      }
                    },
                    child: Text("Ok"))
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
