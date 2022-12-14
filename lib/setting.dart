// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:temple_mandhiram/25drmcodes/constants/app_constants.dart';
import 'package:temple_mandhiram/main.dart';
import 'package:temple_mandhiram/profile.dart';
import 'package:temple_mandhiram/select_lang.dart';

import '25drmcodes/models/profilemodel.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  dynamic height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    Clipboard.setData(ClipboardData(text: getBox.read(userToken)));
    Future<ProfileModel> profileData() async {
      var dio = Dio();
      dio.options.headers["authUser"] = getBox.read(userToken);
      var result = await dio.get("$BASEURL/api/user/fetch");
      return ProfileModel.fromJson(result.data);
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: const Color(0xff003a00),
        elevation: 0,
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
              FutureBuilder(
                  future: profileData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data != null) {
                      return Container(
                        height: height * 0.25,
                        width: width,
                        color: const Color(0xff003a00),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            (snapshot.data!.message == null ||
                                    snapshot.data!.message!.image! != "")
                                ? CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 45,
                                    backgroundImage: CachedNetworkImageProvider(
                                        snapshot.data!.message!.image!),
                                  )
                                : const CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 45,
                                    backgroundImage:
                                        AssetImage('assets/person-icon.png'),
                                  ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              snapshot.data!.message!.name!,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              '+91${snapshot.data!.message!.phone}',
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white60),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container(
                        height: height * 0.25,
                        width: width,
                        color: const Color(0xff003a00),
                        child: Column(
                          children: const [
                            SizedBox(
                              height: 15,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 45,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 43,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              '',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              '',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white60),
                            ),
                          ],
                        ),
                      );
                    }
                  }),
              const SizedBox(
                height: 15,
              ),
              block('Change Language', onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SelectLanguage()));
              }),
              block(
                'Profile',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()));
                },
              ),
              block('Invite Friends'),
              block('Access Mode'),
              block('Support'),
              block('Sign Out', onTap: () {
                getBox.write(isUserLoggedIn, false);
                getBox.write(userToken, "");
                getBox.write(userNumber, "");
                Get.offAll(const SplashScreen());
              }),
            ],
          ),
        ),
      ),
    );
  }

  block(text, {Function? onTap}) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
        width: width,
        decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.green.shade100,
                  blurRadius: 2,
                  spreadRadius: 2,
                  offset: const Offset(-1, 2))
            ]),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
