import 'dart:convert';

LikeModel commentModelFromJson(String str) =>
    LikeModel.fromJson(json.decode(str));

String commentModelToJson(LikeModel data) => json.encode(data.toJson());

class LikeModel {
  LikeModel({
    this.success,
    this.message,
  });

  bool? success;
  List<Message>? message;

  factory LikeModel.fromJson(Map<String, dynamic> json) => LikeModel(
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
    this.phone,
    this.name,
    this.image,
    this.birthDate,
    this.password,
    this.isVerified,
    this.date,
    this.v,
  });

  String? id;
  String? phone;
  String? name;
  String? image;
  DateTime? birthDate;
  String? password;
  bool? isVerified;
  DateTime? date;
  int? v;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["_id"],
        phone: json["phone"],
        name: json["name"],
        image: json["image"],
        birthDate: DateTime.parse(json["birthDate"]),
        password: json["password"],
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
        "password": password,
        "isVerified": isVerified,
        "date": date!.toIso8601String(),
        "__v": v,
      };
}
