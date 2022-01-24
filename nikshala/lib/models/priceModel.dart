class PriceModel {
  //price id
  String id;
  //price
  int price;
  //month
  int months;
  bool val;

  PriceModel({this.price, this.id, this.months, this.val});

  PriceModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["monthPrice"];
    months = json["time"];
    val = false;
  }
}
