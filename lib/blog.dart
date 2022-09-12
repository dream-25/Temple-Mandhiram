// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temple_mandhiram/25drmcodes/contollers/blogcontroller.dart';

import '25drmcodes/constants/app_constants.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  dynamic height, width;

  var controller = Get.put(BlogController());

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    controller.getBlogs();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
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
        title: Image.asset(
          'assets/logo_name.jpeg',
          scale: 5,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SizedBox(
            height: height,
            width: width,
            child: Obx(
              () {
                if (controller.blogModel.value.message != null) {
                  return ListView.builder(
                    itemCount: controller.blogModel.value.message!.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      const Color(0xffeed06e).withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(-1, 1))
                            ]),
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                SizedBox(
                                  height: height * 0.25,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl: controller.blogModel.value
                                          .message![index].image!,
                                      errorWidget: (context, url, error) =>
                                          Container(
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
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.bookmark,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(controller
                                      .blogModel.value.message![index].title ??
                                  ""),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "${DateTime.fromMillisecondsSinceEpoch(controller.blogModel.value.message![index].date!).day.toString()}-${DateTime.fromMillisecondsSinceEpoch(controller.blogModel.value.message![index].date!).month.toString()}-${DateTime.fromMillisecondsSinceEpoch(controller.blogModel.value.message![index].date!).year.toString()}",
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    '${controller.blogModel.value.message![index].like!.toString()} likes',
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 13),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    '${controller.blogModel.value.message![index].comment!.toString()} Comment',
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              endIndent: 10,
                              indent: 10,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.likeABlog(controller
                                        .blogModel.value.message![index].id!);
                                  },
                                  child: Container(
                                    width: width * 0.25,
                                    height: height * 0.05,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(controller.blogModel.value
                                                    .message![index].isLiked ==
                                                0
                                            ? Icons.thumb_up_alt_outlined
                                            : Icons.thumb_up),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          controller
                                                      .blogModel
                                                      .value
                                                      .message![index]
                                                      .isLiked ==
                                                  0
                                              ? 'Like'
                                              : 'Liked',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: height * 0.05,
                                  width: 1,
                                  color: Colors.grey,
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.commentsBlog();
                                  },
                                  child: Container(
                                    width: width * 0.3,
                                    height: height * 0.05,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.comment),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Comment',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: height * 0.05,
                                  width: 1,
                                  color: Colors.grey,
                                ),
                                Container(
                                  width: width * 0.3,
                                  height: height * 0.05,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.share),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${controller.blogModel.value.message![index].share!.toString()} Share',
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    },
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
              },
            ),
          ),
          Visibility(
            visible: controller.isLoading.value,
            child: Container(
              height: Get.height,
              width: Get.width,
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                  child: CircularProgressIndicator(
                color: Colors.green,
                strokeWidth: 7,
              )),
            ),
          ),
        ],
      ),
    );
  }
}
