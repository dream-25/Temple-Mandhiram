// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:temple_mandhiram/25drmcodes/constants/app_constants.dart';
import 'package:temple_mandhiram/dashboard.dart';
import 'package:temple_mandhiram/onboarding_screens.dart';

import 'firebase_options.dart';

void main() async {
  await GetStorage.init();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'Montserrat',
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xff003a00),
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Color(0xff003a00)),
      ),
    ),
    home: const SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  dynamic height, width;

  @override
  void initState() {
    super.initState();
    autoLogin();
  }

  autoLogin() async {
    return Timer(const Duration(seconds: 3), () async {
      if (getBox.read(isUserLoggedIn) != null &&
          getBox.read(isUserLoggedIn) == true) {
        Get.offAll(const Dashboard());
      } else {
        var dio = Dio();
        dio.options.headers["authTemple"] = authToken;
        await dio.get("$BASEURL/api/welcome/fetchall").then((value) {
          Get.offAll(OnBoardingScreens(json: json.encode(value.data)));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xff003a00),
    ));

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: const Color(0xff003a00),
        body: SafeArea(
          child: SizedBox(
            height: height,
            width: width,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              child: Image.asset(
                'assets/new_logo.jpeg',
                scale: 2,
              ),
            ),
          ),
        ));
  }
}
