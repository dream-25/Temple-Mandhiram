import 'dart:convert';

SingleBlogModel singleBlogModelFromJson(String str) =>
    SingleBlogModel.fromJson(json.decode(str));

String singleBlogModelToJson(SingleBlogModel data) =>
    json.encode(data.toJson());

class SingleBlogModel {
  SingleBlogModel({
    this.success,
    this.message,
  });

  bool? success;
  Message? message;

  factory SingleBlogModel.fromJson(Map<String, dynamic> json) =>
      SingleBlogModel(
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
    this.slug,
    this.title,
    this.content,
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
  String? content;
  List<dynamic>? like;
  List<String>? comment;
  List<dynamic>? share;
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
        content: json["content"],
        like: List<dynamic>.from(json["like"].map((x) => x)),
        comment: List<String>.from(json["comment"].map((x) => x)),
        share: List<dynamic>.from(json["share"].map((x) => x)),
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
        "content": content,
        "like": List<dynamic>.from(like!.map((x) => x)),
        "comment": List<dynamic>.from(comment!.map((x) => x)),
        "share": List<dynamic>.from(share!.map((x) => x)),
        "date": date,
        "image": image,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
        "isLiked": isLiked,
      };
}
