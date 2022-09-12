// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:temple_mandhiram/temple_detail.dart';

import '25drmcodes/constants/app_constants.dart';
import '25drmcodes/models/templemodel.dart';

class HomeNewScreen extends StatefulWidget {
  const HomeNewScreen({Key? key}) : super(key: key);

  @override
  _HomeNewScreenState createState() => _HomeNewScreenState();
}

class _HomeNewScreenState extends State<HomeNewScreen> {
  dynamic height, width;
  int current = 0;
  List list = [
    'assets/banner.jpg',
    'assets/banner.jpg',
    'assets/banner.jpg',
    'assets/banner.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    Future<TempleModel> templeData() async {
      var dio = Dio();
      dio.options.headers["authTemple"] = authToken;
      var result = await dio.get("$BASEURL/api/temple/fetchall");
      return TempleModel.fromJson(result.data);
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.03,
              ),
              FutureBuilder<TempleModel>(
                  future: templeData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data != null) {
                      return ListView.builder(
                        itemCount: snapshot.data!.message!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const TempleDetail()));
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: const Color(0xffeed06e)
                                            .withOpacity(0.1),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.fill,
                                            imageUrl: snapshot
                                                .data!.message![index].image!,
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              color: Colors.grey.shade200,
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                Container(
                                              color: Colors.grey.shade200,
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(),
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
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        snapshot.data!.message![index].name!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(snapshot
                                        .data!.message![index].description!),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
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
                  })
            ],
          ),
        ),
      ),
    );
  }

  block(image, text, scale) {
    return Container(
      height: height * 0.07,
      width: width * 0.4,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: const Color(0xffeed06e).withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(-2, 2))
          ]),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, scale: scale, color: const Color(0xff003a00)),
            const SizedBox(
              width: 10,
            ),
            Text(text,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
