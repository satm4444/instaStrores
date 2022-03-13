import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instastores/controllers/data_controller.dart';
import 'package:get/get.dart';
import 'package:instastores/controllers/dialog_loadingbox.dart';
import 'package:instastores/views/homescreen.dart';
import 'package:path/path.dart' as path;

class StoreEditor extends StatefulWidget {
  const StoreEditor({Key? key}) : super(key: key);

  @override
  State<StoreEditor> createState() => _StoreEditorState();
}

class _StoreEditorState extends State<StoreEditor> {
  final DataController data = Get.find();
  final name = TextEditingController();
  final url = TextEditingController();
  final storelink = TextEditingController();
  var gotId = Get.arguments;
  final _imagepicker = ImagePicker();
  File? image;
  String? filename;
  String? gotUrl;
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    final storeData = data.findById(gotId);
    name.text = storeData.name;
    url.text = storeData.imageUrl;
    storelink.text = storeData.storeUrl;
  }

  @override
  void dispose() {
    name.dispose();
    url.dispose();
    storelink.dispose();
    super.dispose();
  }

  Future<void> selectImageGetUrl() async {
    final gotImage = await _imagepicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 500,
      maxHeight: 400,
      imageQuality: 100,
    );
    CommonDialog.showLoading();
    setState(() {
      image = File(gotImage!.path);
      filename = path.basename(image!.path);
      isSelected = true;
    });

    //==FOR GETTING THE URL OF IMAGE==//
    final destination = 'filesStore/$filename';

    final ref = await FirebaseStorage.instance.ref(destination);
    final task = ref.putFile(image!);
    // if (task == null) return;
    final snapshot = await task.whenComplete(() {});
    final urlDown = await snapshot.ref.getDownloadURL();
    gotUrl = urlDown.toString();
    CommonDialog.hideLoading();
  }

  Future<void> submitUpdate() async {
    CommonDialog.showLoading();
    await data.editStore(
        gotId, name.text, storelink.text, isSelected ? gotUrl! : url.text);
    CommonDialog.hideLoading();
    Get.to(() => HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Store Update'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextFormField(
            autofocus: true,
            decoration: InputDecoration(labelText: "Edit Name"),
            controller: name,
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Edit storeLink"),
            controller: storelink,
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
                border: Border.all(
              color: Colors.grey.withOpacity(0.5),
            )),
            child: image == null
                ? Text(
                    "No image here",
                    textAlign: TextAlign.center,
                  )
                : Image.file(
                    image!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
            height: 155,
          ),
          TextButton.icon(
              onPressed: () {
                selectImageGetUrl();
              },
              icon: Icon(Icons.image),
              label: Text("Select image")),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              submitUpdate();
            },
            child: Text('Submit'),
            style: ElevatedButton.styleFrom(primary: Colors.black),
          )
        ],
      ),
    );
  }
}


////====TASK FOR TOMMOROW===////
////===ADD UPDATE FUNCTION FOR CATEGORY IN DATA CONTROLLER===////  ~~~~~~DONE~~~~~~
///====SELECT IMAGE AND GET URL WHEN CLICKED ON SLECT IMAGE OPTION===//// ~~~~~DONE~~~~~
///====SET URL WHEN IMAGE IS CHOSED USING BOOLEAN OTHERWISE PUT THE OLD SAME ONE==//// ~~~DONE~~~
///====DELETE CATEGORY USING ID===/// ~~~~DONE~~~~
///====DO SAME FOR LISTED STORES===///  ~~~~DONE~~~~
