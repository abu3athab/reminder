import 'dart:typed_data';

class ContactModel {
  String? firstName;
  String? lastName;
  String? phoneNumber;
  Uint8List? photo;

  ContactModel({this.firstName, this.lastName, this.phoneNumber, this.photo});

  ContactModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
  }
  toJson() {
    return {'phoneNumber': phoneNumber};
  }
}
