import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';
import 'package:instastores/controllers/dialog_loadingbox.dart';
import 'package:instastores/models/category_model.dart';
import 'package:instastores/models/feedback_model.dart';
import 'package:instastores/models/store.dart';
import 'package:instastores/views/homescreen.dart';

class DataController extends GetxController {
  void onReady() {
    super.onReady();
    fetchCategory();
    fetchStore();
    fetchFeedback();
  }

  var StoreCount;
  var CategoryId;

  List<CategoryModel> items = [];

  List<StoreModel> storeItems = [];
  List<StoreModel> filtered = [];
  List<Feedback> feedbackItems = [];

  CategoryModel findViaId(String id) {
    return items.firstWhere((element) => element.id == id);
  }

  StoreModel findById(String id) {
    return storeItems.firstWhere((element) => element.id == id);
  }

  void back() {
    filtered = [];
    Get.back();
  }

  void cleanwhenWillpop() {
    filtered = [];
  }
//===FINDING STORES LIST BY USING CATEGORY ID===//

  void findList(List<StoreModel> lists, String id) {
    final foundList = lists.where((element) => element.categoryID == id);
    filtered.addAll(foundList);
  }

  //====ADD CATEGORY TO FIRESTORE===//

  Future<void> addCategory(String name, String imageUrl) async {
    try {
      final response =
          await FirebaseFirestore.instance.collection('categorylist').add({
        'category_name': name,
        'image_url': imageUrl,
        'created_at': FieldValue.serverTimestamp(),
      });
      Get.back();
      // Get.to(() => HomeScreen());
      fetchCategory();
    } catch (e) {
      print(e);
    }
  }
  //=====FETCH CATEGORY LIST FROM DATABASE=====//

  Future<void> fetchCategory() async {
    items = [];
    try {
      final List<CategoryModel> categoryData = [];
      var response = await FirebaseFirestore.instance
          .collection('categorylist')
          .orderBy('created_at', descending: false)
          .get();
      if (response.docs.length > 0) {
        response.docs.forEach((element) {
          categoryData.add(CategoryModel(
            id: element.id,
            name: element['category_name'],
            imageUrl: element['image_url'],
          ));
        });
      }
      items.addAll(categoryData);
      //  print(categoryData);
      update();
    } catch (e) {
      print(e);
    }
  }

  Future<void> addStore(
      String name, String storeUrl, String categoryId, String imageUrl) async {
    try {
      final response =
          await FirebaseFirestore.instance.collection('storeList').add({
        'store_name': name,
        'store_url': storeUrl,
        'category_id': categoryId,
        'image_url': imageUrl,
        'created_at': FieldValue.serverTimestamp()
      });
      filtered = [];
      Get.off(() => HomeScreen());
      fetchStore();
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchStore() async {
    filtered = [];
    storeItems = [];
    try {
      List<StoreModel> loadedStore = [];
      final response = await FirebaseFirestore.instance
          .collection('storeList')
          .orderBy('created_at', descending: false)
          .get();

      if (response.docs.length > 0) {
        response.docs.forEach((element) {
          loadedStore.add(StoreModel(
            id: element.id,
            categoryID: element['category_id'],
            name: element['store_name'],
            storeUrl: element['store_url'],
            imageUrl: element['image_url'],
          ));
        });
      }
      storeItems.addAll(loadedStore);

      update();
    } catch (e) {
      print(e);
    }
  }

  void getStoreNumber() {
    final nums = filtered.length;
    StoreCount = nums;
  }

  //=====FOR FEEDBACK====//

  Future<void> addFeedback(String feedmsg, String mail) async {
    try {
      final response =
          await FirebaseFirestore.instance.collection('feedback').add({
        'user_feedback': feedmsg,
        'user_mail': mail,
        'created_at': FieldValue.serverTimestamp(),
      });
      fetchFeedback();
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchFeedback() async {
    feedbackItems = [];
    try {
      List<Feedback> loadedFeedbacks = [];

      final response = await FirebaseFirestore.instance
          .collection('feedback')
          .orderBy('created_at', descending: false)
          .get();

      if (response.docs.length > 0) {
        response.docs.forEach((element) {
          loadedFeedbacks.add(Feedback(
            element['user_mail'],
            element['user_feedback'],
          ));
        });
      }
      feedbackItems.addAll(loadedFeedbacks);
      update();
    } catch (e) {
      print(e);
    }
  }

  ///====FOR EDITING AND UPDATING THE CATEGORY====///

  Future<void> editCategory(String catId, String catName, String catUrl) async {
    try {
      await FirebaseFirestore.instance
          .collection('categorylist')
          .doc(catId)
          .update({
        'category_name': catName,
        'image_url': catUrl,
      });
      fetchCategory();
    } catch (e) {
      print(e);
    }
  }

  ////=====FOR DELETING THE CATEGORY====////
  Future<void> deletCategory(String id) async {
    try {
      CommonDialog.showLoading();
      await FirebaseFirestore.instance
          .collection('categorylist')
          .doc(id)
          .delete();

      fetchCategory();
      CommonDialog.hideLoading();
    } catch (e) {}
  }

  //====FOR EDITING AND UPDATING THE STORE===//
  Future<void> editStore(
      String storeId, String name, String storeUrl, String imageUrl) async {
    try {
      await FirebaseFirestore.instance
          .collection('storeList')
          .doc(storeId)
          .update({
        'store_name': name,
        'store_url': storeUrl,
        'image_url': imageUrl,
      });
      fetchStore();
    } catch (e) {
      print(e);
    }
  }

  ////=====FOR DELETING THE CATEGORY====////
  Future<void> deletStore(String id) async {
    try {
      CommonDialog.showLoading();
      await FirebaseFirestore.instance.collection('storeList').doc(id).delete();

      fetchStore();
      CommonDialog.hideLoading();
      Get.back();
    } catch (e) {
      print(e);
    }
  }
}
