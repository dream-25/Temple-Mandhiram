import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temple_mandhiram/25drmcodes/models/blogmodel.dart';

import '../constants/app_constants.dart';

class BlogController extends GetxController {
  var blogModel = BlogModel().obs;
  var isLoading = false.obs;
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

  void commentsBlog() {
    Get.bottomSheet(Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      height: Get.height * 0.80,
      child: Column(
        children: const [
          SizedBox(height: 16),
          Text(
            "Comments",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Divider(thickness: 1),
        ],
      ),
    ));
  }
}
