// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '25drmcodes/constants/app_constants.dart';
import '25drmcodes/models/blogmodel.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  dynamic height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    Future<BlogModel> blogData() async {
      var dio = Dio();
      dio.options.headers["authTemple"] = authToken;
      var result = await dio.get("$BASEURL/api/blog/fetchall");
      return BlogModel.fromJson(result.data);
    }

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
      body: SizedBox(
        height: height,
        width: width,
        child: FutureBuilder<BlogModel>(
          future: blogData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null) {
              return ListView.builder(
                itemCount: snapshot.data!.message!.length,
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
                              color: const Color(0xffeed06e).withOpacity(0.1),
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
                                  imageUrl:
                                      snapshot.data!.message![index].image!,
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
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child:
                              Text(snapshot.data!.message![index].title ?? ""),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "${DateTime.fromMillisecondsSinceEpoch(snapshot.data!.message![index].date!).day.toString()}-${DateTime.fromMillisecondsSinceEpoch(snapshot.data!.message![index].date!).month.toString()}-${DateTime.fromMillisecondsSinceEpoch(snapshot.data!.message![index].date!).year.toString()}",
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                '${snapshot.data!.message![index].like!.toString()} likes',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 13),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                '${snapshot.data!.message![index].comment!.toString()} Comment',
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
                            Container(
                              width: width * 0.25,
                              height: height * 0.05,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.thumb_up_alt_outlined),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Like',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                ],
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
                                children: const [
                                  Icon(Icons.comment),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Comment',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                ],
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
                                    '${snapshot.data!.message![index].share!.toString()} Share',
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
    );
  }
}
