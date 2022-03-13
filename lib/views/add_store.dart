import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instastores/controllers/data_controller.dart';
import 'package:instastores/controllers/dialog_loadingbox.dart';

import 'package:instastores/controllers/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:get/get.dart';

class AddStore extends StatefulWidget {
  const AddStore({Key? key}) : super(key: key);

  @override
  State<AddStore> createState() => _AddStoreState();
}

class _AddStoreState extends State<AddStore> {
  final _formKey = GlobalKey<FormState>();
  final DataController dataController = Get.find();
  UploadTask? task;
  //====FOR PICKING IMAGE FROM SOURCE===//
  // final ImagePicker imgagePicker = ImagePicker();
  File? image;
  String? filename;
  String? imageeUrl;

  Future<void> getImage() async {
    final selectedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 500,
      maxHeight: 400,
      imageQuality: 100,
    );

    setState(() {
      image = File(selectedImage!.path);
      filename = path.basename(image!.path);
      print("here is the $filename");
    });
  }

  //====FORM SUBMIT & ADD CATEGORY FUNCTION===//
  var storeTitle;
  var storeUrl;
  var gotdatafromWidget = Get.arguments;

  Future<void> _saveForm() async {
    CommonDialog.showLoading();
    if (_formKey.currentState!.validate()) {
      print('form is valid');
      _formKey.currentState!.save();
      print('saved');
    }

    final destination = 'filesStore/$filename';
    task = FirebaseApi.uploadFile(destination, image!);
    if (task == null) return;
    final snapshot = await task!.whenComplete(() {});
    final urllDownload = await snapshot.ref.getDownloadURL();
    imageeUrl = urllDownload.toString();

    dataController.addStore(
        storeTitle, storeUrl, gotdatafromWidget[0], imageeUrl!);
    CommonDialog.hideLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD STORE"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: 'ADD STORE NAME'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Category Empty";
                  }
                  return null;
                },
                onSaved: (value) {
                  storeTitle = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'ADD STORE URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Category Empty";
                  }
                  return null;
                },
                onSaved: (value) {
                  storeUrl = value;
                },
              ),
              SizedBox(
                height: 20,
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
                    getImage();
                  },
                  icon: Icon(Icons.image),
                  label: Text("Select image")),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                  onPressed: () async {
                    await _saveForm();
                  },
                  icon: Icon(Icons.add),
                  label: Text('ADD'))
            ],
          ),
        ),
      ),
    );
  }
}
