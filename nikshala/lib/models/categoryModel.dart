class CategoryModel {
  //category name
  String categoryName;
  //category id
  String id;

  CategoryModel({this.categoryName, this.id});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryName = json["categoryName"];
    id = json["id"];
  }
}
