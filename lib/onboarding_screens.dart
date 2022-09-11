// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:temple_mandhiram/25drmcodes/constants/app_constants.dart';
import 'package:temple_mandhiram/25drmcodes/models/onboardmodel.dart';
import 'package:temple_mandhiram/Common/common_button.dart';

import 'login.dart';

class OnBoardingScreens extends StatefulWidget {
  String json;
  OnBoardingScreens({required this.json, Key? key}) : super(key: key);

  @override
  _OnBoardingScreensState createState() => _OnBoardingScreensState();
}

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  dynamic height, width;
  final controller = PageController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xffffffff),
    ));

    var onboardScreenModel =
        OnboardScreenModel.fromJson(json.decode(widget.json));

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          children: [
            SizedBox(
              height: height,
              width: width,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.1,
                  ),
                  SizedBox(
                    height: height * 0.3,
                    width: width * 0.6,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: onboardScreenModel.message!.first.image!,
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
                  SizedBox(
                    height: height * 0.06,
                  ),
                  Text(
                    onboardScreenModel.message!.first.heading!,
                    style: const TextStyle(
                        color: COLORPRIMARYDARK,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SizedBox(
                    width: width * 0.8,
                    child: Text(
                      onboardScreenModel.message!.first.description!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Color(0xff003a00),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height,
              width: width,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.1,
                  ),
                  SizedBox(
                    height: height * 0.3,
                    width: width * 0.6,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: onboardScreenModel.message![1].image!,
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
                  SizedBox(
                    height: height * 0.06,
                  ),
                  Text(
                    onboardScreenModel.message![1].heading!,
                    style: const TextStyle(
                        color: Color(0xff003a00),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SizedBox(
                    width: width * 0.8,
                    child: Text(
                      onboardScreenModel.message![1].description!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Color(0xff003a00),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 2,
                effect: WormEffect(
                    dotColor: const Color(0xff003a00).withOpacity(0.5),
                    activeDotColor: const Color(0xff003a00),
                    spacing: 16,
                    strokeWidth: 1),
              ),
            ),
            const SizedBox(
              width: 70,
            ),
            TextButton(
              onPressed: () {
                Get.defaultDialog(
                    titlePadding: const EdgeInsets.all(20),
                    title: "Developer Warning",
                    middleText:
                        "This application is under development you may face some errors\n This dialog will be removed after completion of the project and payment",
                    actions: [
                      CommonButton(
                          text: "Next",
                          color: Colors.green,
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const LoginScreen()));
                          })
                    ]);
              },
              child: const Text(
                'Continue',
                style: TextStyle(color: Color(0xff000000)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
