import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:temple_mandhiram/Common/common_button.dart';

import 'login.dart';

class OnBoardingScreens extends StatefulWidget {
  const OnBoardingScreens({Key? key}) : super(key: key);

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
                      child: Image.asset(
                        'assets/temp.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.06,
                  ),
                  const Text(
                    'Introduction',
                    style: TextStyle(
                        color: Color(0xff003a00),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SizedBox(
                    width: width * 0.8,
                    child: const Text(
                      'Lorem ipsum dolor sit amet. A provident delectus non minus vero ut eaque explicabo. Et omnis rerum ea optio provident est debitis voluptatibus vel optio quas et dolorem consectetur',
                      textAlign: TextAlign.center,
                      style: TextStyle(
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
                      child: Image.asset(
                        'assets/temp.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.06,
                  ),
                  const Text(
                    'Introduction',
                    style: TextStyle(
                        color: Color(0xff003a00),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SizedBox(
                    width: width * 0.8,
                    child: const Text(
                      'Lorem ipsum dolor sit amet. A provident delectus non minus vero ut eaque explicabo. Et omnis rerum ea optio provident est debitis voluptatibus vel optio quas et dolorem consectetur',
                      textAlign: TextAlign.center,
                      style: TextStyle(
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
