// To parse this JSON data, do
//
//     final templeModel = templeModelFromJson(jsonString);

import 'dart:convert';

TempleModel templeModelFromJson(String str) =>
    TempleModel.fromJson(json.decode(str));

String templeModelToJson(TempleModel data) => json.encode(data.toJson());

class TempleModel {
  TempleModel({
    this.success,
    this.message,
  });

  bool? success;
  List<Message>? message;

  factory TempleModel.fromJson(Map<String, dynamic> json) => TempleModel(
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
    this.name,
    this.location,
    this.description,
    this.image,
    this.openingTime,
    this.closingTime,
    this.v,
  });

  String? id;
  String? name;
  String? location;
  String? description;
  String? image;
  int? openingTime;
  int? closingTime;
  int? v;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["_id"],
        name: json["name"],
        location: json["location"],
        description: json["description"],
        image: json["image"],
        openingTime: json["openingTime"],
        closingTime: json["closingTime"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "location": location,
        "description": description,
        "image": image,
        "openingTime": openingTime,
        "closingTime": closingTime,
        "__v": v,
      };
}
