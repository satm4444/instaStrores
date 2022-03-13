import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instastores/controllers/data_controller.dart';
import 'package:instastores/controllers/dialog_loadingbox.dart';
import 'package:instastores/controllers/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:get/get.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final _formKey = GlobalKey<FormState>();
  final DataController dataController = Get.find();
  UploadTask? task;
  //====FOR PICKING IMAGE FROM SOURCE===//
  // final ImagePicker imgagePicker = ImagePicker();
  File? image;
  String? filename;
  String? imageUrl;

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
  var categoryTitle;

  Future<void> _saveForm() async {
    CommonDialog.showLoading();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
    //~Upload and downlaod image url from firebase storage
    final destination = 'files/$filename';
    // final ref = FirebaseStorage.instance.ref(destination);
    //final task = ref.putFile(image!);
    task = FirebaseApi.uploadFile(destination, image!);
    if (task == null) return;
    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    imageUrl = urlDownload.toString();
    print('immmmmmmmmmmggggg $imageUrl');
    dataController.addCategory(categoryTitle, imageUrl!);
    CommonDialog.hideLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD CATEGORY"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: 'ADD CATEGORY NAME'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Category Empty";
                  }
                  return null;
                },
                onSaved: (value) {
                  categoryTitle = value;
                },
              ),
              SizedBox(
                height: 20,
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
                  onPressed: () {
                    _saveForm();
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
