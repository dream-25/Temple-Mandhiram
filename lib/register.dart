import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '25drmcodes/constants/app_constants.dart';
import 'Common/common_button.dart';
import 'Common/common_text_field.dart';
import 'dashboard.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  dynamic height, width;
  TextEditingController mobile = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController dob = TextEditingController();
  var isLoading = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      dob.text = "${picked.year}-${picked.month}-${picked.day}";
    }
  }

  void registerAPI(
    String mobile,
    String pass,
    String name,
    String age,
    String dob,
  ) async {
    setState(() {
      isLoading = true;
    });

    var dio = Dio();
    var body = {
      "phone": mobile,
      "password": pass,
      "name": name,
      "birthDate": dob
    };
    dio.options.headers["authTemple"] = authToken;
    await dio
        .post("$BASEURL/api/user/register",
            data: body,
            options: Options(
              validateStatus: (status) => true,
            ))
        .then((value) {
      log(json.encode(value.data));
      log(value.statusCode.toString());
      setState(() {
        isLoading = false;
      });
      if (value.statusCode == 200) {
        getBox.write(userToken, value.data["authUser"]);
        Get.offAll(const Dashboard());
      } else if (value.statusCode == 404) {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: value.data["message"],
          duration: const Duration(milliseconds: 3000),
        ));
      } else if (value.statusCode == 400) {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: value.data["message"],
          duration: const Duration(milliseconds: 3000),
        ));
      } else {
        Get.showSnackbar(const GetSnackBar(
          backgroundColor: Colors.red,
          message: "Something went wrong",
          duration: Duration(milliseconds: 3000),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xff003a00),
    ));

    return Scaffold(
        backgroundColor: const Color(0xff003a00),
        body: SafeArea(
            child: Stack(
          children: [
            SizedBox(
              height: height,
              width: width,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Image.asset(
                          'assets/new_logo.jpeg',
                          scale: 6,
                        ),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Register',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        CommonTextField(
                          enabled: true,
                          hintText: 'Name',
                          textInputType: TextInputType.text,
                          obscure: false,
                          controller: name,
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        CommonTextField(
                          enabled: true,
                          hintText: 'Mobile number',
                          textInputType: TextInputType.number,
                          obscure: false,
                          controller: mobile,
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        InkWell(
                          onTap: () => _selectDate(context),
                          child: CommonTextField(
                            enabled: false,
                            hintText: 'Date of Birth',
                            textInputType: TextInputType.text,
                            obscure: false,
                            controller: dob,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        CommonTextField(
                          enabled: true,
                          hintText: 'Password',
                          textInputType: TextInputType.text,
                          obscure: true,
                          controller: pass,
                        ),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        CommonButton(
                          onTap: () {
                            if (name.text.length > 3) {
                              if (mobile.text.length == 10) {
                                if (dob.text.isNotEmpty) {
                                  if (pass.text.length > 7) {
                                    registerAPI(
                                        mobile.text.toString(),
                                        pass.text.toString(),
                                        name.text.toString(),
                                        age.text.toString(),
                                        dob.text.toString());
                                  } else {
                                    Get.showSnackbar(const GetSnackBar(
                                      backgroundColor: Colors.red,
                                      message:
                                          "Password should be 8 characters long",
                                      duration: Duration(milliseconds: 3000),
                                    ));
                                  }
                                } else {
                                  Get.showSnackbar(const GetSnackBar(
                                    backgroundColor: Colors.red,
                                    message: "Please enter a valid DOB",
                                    duration: Duration(milliseconds: 3000),
                                  ));
                                }
                              } else {
                                Get.showSnackbar(const GetSnackBar(
                                  backgroundColor: Colors.red,
                                  message: "Please enter a valid Number",
                                  duration: Duration(milliseconds: 3000),
                                ));
                              }
                            } else {
                              Get.showSnackbar(const GetSnackBar(
                                backgroundColor: Colors.red,
                                message: "Please enter a valid Name",
                                duration: Duration(milliseconds: 3000),
                              ));
                            }
                          },
                          color: Colors.green,
                          text: 'Register',
                          width: width * 0.9,
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isLoading,
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
        )));
  }
}
