import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temple_mandhiram/25drmcodes/models/blogmodel.dart';

import '../constants/app_constants.dart';
import '../models/commentmodel.dart';
import '../models/likemodel.dart';

class BlogController extends GetxController {
  var blogModel = BlogModel().obs;
  var commentModel = CommentModel().obs;
  var likeModel = LikeModel().obs;
  var isLoading = false.obs;
  var listViewScrollController = ScrollController();
  var commentController = TextEditingController();
  void getBlogs() async {
    var dio = Dio();
    dio.options.headers["authUser"] = getBox.read(userToken);
    var result = await dio.get("$BASEURL/api/blog/fetchall");
    blogModel.update((val) {
      blogModel = BlogModel.fromJson(result.data).obs;
    });
  }

  void likeABlog(String blogID) async {
    isLoading.update((val) {
      isLoading = true.obs;
    });
    var dio = Dio();
    dio.options.headers["authUser"] = getBox.read(userToken);
    await dio.put("$BASEURL/api/blog/like", data: {"blogId": blogID}).then(
        (value) async {
      isLoading.update((val) {
        isLoading = false.obs;
      });
      var dio = Dio();
      dio.options.headers["authUser"] = getBox.read(userToken);
      var result = await dio.get("$BASEURL/api/blog/fetchall");
      blogModel.update((val) {
        blogModel = BlogModel.fromJson(result.data).obs;
      });
    });
  }

  void commentABlog(String blogID) async {
    var dio = Dio();
    dio.options.headers["authUser"] = getBox.read(userToken);
    (commentController.text.isNotEmpty)
        ? await dio.put("$BASEURL/api/blog/comment",
            data: {"blogId": blogID, "comment": commentController.text})
        : null;
    commentController.text = "";
    dio.options.headers["authTemple"] = authToken;
    await dio.post("$BASEURL/api/blog/comment", data: {"blogId": blogID}).then(
        (value) => commentModel.update((val) {
              commentModel = CommentModel.fromJson(value.data).obs;
            }));
    dio.options.headers["authUser"] = getBox.read(userToken);
    var result = await dio.get("$BASEURL/api/blog/fetchall");
    blogModel.update((val) {
      blogModel = BlogModel.fromJson(result.data).obs;
    });
  }

  void commentsBlog(String blogID) async {
    Get.bottomSheet(Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          const SizedBox(height: 16),
          const Text(
            "Comments",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const Divider(thickness: 1),
          Expanded(
              child: Obx(() => (commentModel.value.message != null)
                  ? ListView.builder(
                      controller: listViewScrollController,
                      itemCount: commentModel.value.message!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 6),
                              (commentModel.value.message == null ||
                                      commentModel
                                              .value.message![index].image! !=
                                          "")
                                  ? CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 20,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                              commentModel.value.message![index]
                                                  .image!),
                                    )
                                  : const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 20,
                                      backgroundImage:
                                          AssetImage('assets/person-icon.png'),
                                    ),
                              const SizedBox(width: 12),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    commentModel.value.message![index].name!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: COLORPRIMARYDARK,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width - 100,
                                    child: Text(
                                      commentModel
                                          .value.message![index].comment!,
                                      overflow: TextOverflow.clip,
                                      textAlign: TextAlign.justify,
                                      maxLines: null,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: COLORPRIMARYDARK,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      })
                  : const Center(
                      child: Text("Be the First Person to Comment"),
                    ))),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextFormField(
              controller: commentController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Comment",
                  suffixIcon: InkWell(
                    onTap: () {
                      commentABlog(blogID);
                    },
                    child: const Icon(
                      Icons.send,
                      color: COLORPRIMARYDARK,
                    ),
                  ),
                  hintStyle: const TextStyle(color: Colors.grey)),
            ),
          ),
          const Divider(thickness: 2),
          const SizedBox(
            height: 8,
          )
        ],
      ),
    ));

    var dio = Dio();
    dio.options.headers["authUser"] = getBox.read(userToken);
    await dio.post("$BASEURL/api/blog/comment", data: {"blogId": blogID}).then(
      (value) => commentModel.update(
        (val) {
          commentModel = CommentModel.fromJson(value.data).obs;
        },
      ),
    );
  }

  void viewLikers(String blogID) async {
    Get.bottomSheet(Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          const SizedBox(height: 16),
          const Text(
            "Likes",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const Divider(thickness: 1),
          Expanded(
              child: Obx(() => (likeModel.value.message != null)
                  ? ListView.builder(
                      controller: listViewScrollController,
                      itemCount: likeModel.value.message!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 6),
                              (likeModel.value.message == null ||
                                      likeModel.value.message![index].image! !=
                                          "")
                                  ? CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 20,
                                      backgroundImage:
                                          CachedNetworkImageProvider(likeModel
                                              .value.message![index].image!),
                                    )
                                  : const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 20,
                                      backgroundImage:
                                          AssetImage('assets/person-icon.png'),
                                    ),
                              const SizedBox(width: 12),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    likeModel.value.message![index].name!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: COLORPRIMARYDARK,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width - 100,
                                    child: const Text(
                                      "Liked this Blog",
                                      overflow: TextOverflow.clip,
                                      textAlign: TextAlign.justify,
                                      maxLines: null,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: COLORPRIMARYDARK,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      })
                  : const Center(
                      child: Text("Be the First Person to Like"),
                    ))),
          const Divider(thickness: 2),
          const SizedBox(
            height: 8,
          )
        ],
      ),
    ));
    var dio = Dio();
    dio.options.headers["authTemple"] = authToken;
    await dio.post("$BASEURL/api/blog/like", data: {"blogId": blogID}).then(
      (value) => likeModel.update(
        (val) {
          likeModel = LikeModel.fromJson(value.data).obs;
        },
      ),
    );
  }
}
