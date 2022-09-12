// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    this.success,
    this.message,
  });

  bool? success;
  Message? message;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        success: json["success"],
        message: Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message!.toJson(),
      };
}

class Message {
  Message({
    this.id,
    this.phone,
    this.name,
    this.image,
    this.birthDate,
    this.isVerified,
    this.date,
    this.v,
  });

  String? id;
  String? phone;
  String? name;
  String? image;
  DateTime? birthDate;
  bool? isVerified;
  DateTime? date;
  int? v;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["_id"],
        phone: json["phone"],
        name: json["name"],
        image: json["image"],
        birthDate: DateTime.parse(json["birthDate"]),
        isVerified: json["isVerified"],
        date: DateTime.parse(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "phone": phone,
        "name": name,
        "image": image,
        "birthDate": birthDate!.toIso8601String(),
        "isVerified": isVerified,
        "date": date!.toIso8601String(),
        "__v": v,
      };
}
