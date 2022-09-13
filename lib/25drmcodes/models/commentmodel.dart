import 'dart:convert';

CommentModel commentModelFromJson(String str) =>
    CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
  CommentModel({
    this.success,
    this.message,
  });

  bool? success;
  List<Message>? message;

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
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
    this.comment,
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
  String? comment;

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
        comment: json["comment"],
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
        "comment": comment,
      };
}
