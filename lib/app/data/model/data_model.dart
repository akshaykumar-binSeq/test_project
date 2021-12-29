// To parse this JSON data, do
//
//     final userDetails = userDetailsFromJson(jsonString);

import 'dart:convert';

List<UserDetails> userDetailsFromJson(String str) => List<UserDetails>.from(
    json.decode(str).map((x) => UserDetails.fromJson(x)));

String userDetailsToJson(List<UserDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserDetails {
  UserDetails({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.gender,
  });

  String? id;
  String? name;
  String? email;
  String? mobile;
  String? gender;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "gender": gender,
      };

  UserDetails.fromMap(Map map) {
    id = map["_id"];
    name = map["name"];
    email = map["email"];
    mobile = map["mobile"];
    gender = map["gender"];
  }
}
