//====CREATE MODEL OF STORE==//

class StoreModel {
  final String id;
  final String categoryID;

  final String name;
  final String storeUrl;
  final String imageUrl;

  StoreModel({
    required this.id,
    required this.categoryID,
    required this.name,
    required this.storeUrl,
    required this.imageUrl,
  });
}
