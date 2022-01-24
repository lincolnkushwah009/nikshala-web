class UserModel {
  //user id
  String id;
  //user first name
  String firstName;
  //user last name
  String lastName;
  //user full name
  String fullName;
  //cart items
  int cartItem;

  UserModel(
      {this.id, this.firstName, this.lastName, this.fullName, this.cartItem});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    fullName = json["fullName"];
    cartItem = json['totalCartItemCount'];
  }
}
