import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instastores/controllers/data_controller.dart';
import 'package:get/get.dart';
import 'package:instastores/controllers/dialog_loadingbox.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({Key? key}) : super(key: key);

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final DataController dataController = Get.find();
  final _key = GlobalKey<FormState>();
  String? feedback;
  void _saveForm() async {
    CommonDialog.showLoading();
    if (_key.currentState!.validate()) {
      print('form valid');
      _key.currentState!.save();
      print('form saved');
    }
    dataController.addFeedback(feedback!, user!.email!);
    CommonDialog.hideLoading();
    Get.back();
    Get.snackbar(
      'Successfully Sent',
      'Thanks for your feedback.',
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 0,
      backgroundColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Form(
          key: _key,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: deviceSize.height * 0.3,
                  width: deviceSize.width,
                  child: TextFormField(
                    maxLines: 14,
                    decoration: InputDecoration(
                      fillColor: Colors.black.withOpacity(0.03),
                      filled: true,
                      hintText: "Type your feedback...",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "No message here !";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      feedback = value;
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  onPressed: () {
                    _saveForm();
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  label: Text("Send"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
