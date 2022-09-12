// To parse this JSON data, do
//
//     final familyModel = familyModelFromJson(jsonString);

import 'dart:convert';

FamilyModel familyModelFromJson(String str) =>
    FamilyModel.fromJson(json.decode(str));

String familyModelToJson(FamilyModel data) => json.encode(data.toJson());

class FamilyModel {
  FamilyModel({
    this.success,
    this.message,
  });

  bool? success;
  List<Message>? message;

  factory FamilyModel.fromJson(Map<String, dynamic> json) => FamilyModel(
        success: json["success"],
        message:
            List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": List<dynamic>.from(message!.map((x) => x.toJson())),
      };
}

class Message {
  Message({
    this.id,
    this.userId,
    this.name,
    this.birthDate,
    this.gender,
    this.relation,
    this.location,
    this.gotra,
    this.date,
    this.v,
  });

  String? id;
  String? userId;
  String? name;
  DateTime? birthDate;
  String? gender;
  String? relation;
  String? location;
  String? gotra;
  DateTime? date;
  int? v;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["_id"],
        userId: json["userId"],
        name: json["name"],
        birthDate: DateTime.parse(json["birthDate"]),
        gender: json["gender"],
        relation: json["relation"],
        location: json["location"],
        gotra: json["gotra"],
        date: DateTime.parse(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "name": name,
        "birthDate": birthDate!.toIso8601String(),
        "gender": gender,
        "relation": relation,
        "location": location,
        "gotra": gotra,
        "date": date!.toIso8601String(),
        "__v": v,
      };
}
