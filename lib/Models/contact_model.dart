class ContactModel {
  String? name;
  String? phoneNumber;

  ContactModel({this.name, this.phoneNumber});

  ContactModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
  }
  toJson() {
    return {'name': name, 'phoneNumber': phoneNumber};
  }
}
