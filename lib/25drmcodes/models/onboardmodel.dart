import 'dart:convert';

OnboardScreenModel onboardScreenModelFromJson(String str) =>
    OnboardScreenModel.fromJson(json.decode(str));

String onboardScreenModelToJson(OnboardScreenModel data) =>
    json.encode(data.toJson());

class OnboardScreenModel {
  OnboardScreenModel({
    this.success,
    this.message,
  });

  bool? success;
  List<Message>? message;

  factory OnboardScreenModel.fromJson(Map<String, dynamic> json) =>
      OnboardScreenModel(
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
    this.heading,
    this.description,
    this.image,
    this.v,
  });

  String? id;
  String? heading;
  String? description;
  String? image;
  int? v;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["_id"],
        heading: json["heading"],
        description: json["description"],
        image: json["image"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "heading": heading,
        "description": description,
        "image": image,
        "__v": v,
      };
}
