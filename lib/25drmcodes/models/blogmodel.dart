import 'dart:convert';

BlogModel blogModelFromJson(String str) => BlogModel.fromJson(json.decode(str));

String blogModelToJson(BlogModel data) => json.encode(data.toJson());

class BlogModel {
  BlogModel({
    this.success,
    this.message,
  });

  bool? success;
  List<Message>? message;

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
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
    this.slug,
    this.title,
    this.like,
    this.comment,
    this.share,
    this.date,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isLiked,
  });

  String? id;
  String? slug;
  String? title;
  int? like;
  int? comment;
  int? share;
  int? date;
  String? image;
  int? createdAt;
  int? updatedAt;
  int? v;
  int? isLiked;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["_id"],
        slug: json["slug"],
        title: json["title"],
        like: json["like"],
        comment: json["comment"],
        share: json["share"],
        date: json["date"],
        image: json["image"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
        isLiked: json["isLiked"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "slug": slug,
        "title": title,
        "like": like,
        "comment": comment,
        "share": share,
        "date": date,
        "image": image,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
        "isLiked": isLiked,
      };
}
