// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:temple_mandhiram/25drmcodes/models/singleblogmodel.dart';

import '../constants/app_constants.dart';

class SingleBlog extends StatelessWidget {
  String blogID;

  SingleBlog({
    required this.blogID,
    super.key,
  });

  Future<SingleBlogModel> blogData() async {
    var dio = Dio();
    dio.options.headers["authUser"] = getBox.read(userToken);
    var result = await dio.get("$BASEURL/api/blog/fetch/$blogID");
    return SingleBlogModel.fromJson(result.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff003a00),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/logo_temple.jpeg',
              scale: 10,
              fit: BoxFit.cover,
            ),
          ),
          title: const Text("Blog Details"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder(
              future: blogData(),
              builder: (context, snapshot) {
                if (snapshot.data != null &&
                    snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Title: ${snapshot.data!.message!.title!}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: COLORPRIMARYDARK,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        width: Get.width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: snapshot.data!.message!.image!,
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey.shade200,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            placeholder: (context, url) => Container(
                              color: Colors.grey.shade200,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      HtmlWidget(
                        snapshot.data!.message!.content!,
                      ),
                    ],
                  );
                } else {
                  return Container(
                    alignment: Alignment.center,
                    child: const SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: COLORPRIMARYDARK,
                      ),
                    ),
                  );
                }
              }),
        ));
  }
}
