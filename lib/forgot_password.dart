// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '25drmcodes/constants/app_constants.dart';
import 'Common/common_button.dart';
import 'Common/common_text_field.dart';
import 'dashboard.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  var isLoading = false;
  dynamic height, width;
  TextEditingController mobile = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController cpass = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String verificationIDR = "";

  @override
  Widget build(BuildContext context) {
    Future<bool> willPopCallback() async {
      setState(() {
        isLoading = false;
      });
      return true;
    }

    void verifyOTP(String otp) async {
      setState(() {
        isLoading = true;
      });
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationIDR, smsCode: otp);

        await _auth.signInWithCredential(credential).then((value) async {
          Navigator.of(Get.overlayContext!).pop();
          setState(() {
            isLoading = true;
          });

          Get.defaultDialog(
            titleStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: const Color(0xff003a00),
            title: "Update Password",
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonTextField(
                  enabled: true,
                  hintText: 'Password',
                  textInputType: TextInputType.text,
                  obscure: true,
                  controller: pass,
                ),
                const SizedBox(height: 12),
                CommonTextField(
                  enabled: true,
                  hintText: 'Confirm Password',
                  textInputType: TextInputType.text,
                  obscure: true,
                  controller: cpass,
                ),
                const SizedBox(height: 16),
                CommonButton(
                  onTap: () async {
                    if (pass.text == cpass.text) {
                      if (pass.text.length > 7) {
                        var dio = Dio();
                        var body = <String, dynamic>{
                          "phone": mobile.text.toString(),
                          "password": pass.text.toString(),
                        };
                        dio.options.headers["authTemple"] = authToken;
                        await dio
                            .put("$BASEURL/api/user/update",
                                data: body,
                                options: Options(
                                  validateStatus: (status) => true,
                                ))
                            .then((value) {
                          log(json.encode(value.data));
                          setState(() {
                            isLoading = false;
                          });
                          if (value.statusCode == 200) {
                            getBox.write(userToken, value.data["authUser"]);
                            getBox.write(userNumber, mobile.text);
                            getBox.write(isUserLoggedIn, true);
                            Get.offAll(const Dashboard());
                          } else {
                            Get.showSnackbar(GetSnackBar(
                              backgroundColor: Colors.red,
                              message: value.data["message"],
                              duration: const Duration(milliseconds: 3000),
                            ));
                          }
                        });
                      } else {
                        Get.showSnackbar(const GetSnackBar(
                          backgroundColor: Colors.red,
                          message: "Password should be 8 characters long",
                          duration: Duration(milliseconds: 3000),
                        ));
                      }
                    } else {
                      Get.showSnackbar(const GetSnackBar(
                        backgroundColor: Colors.red,
                        message: "Password and Confirm Password Should be same",
                        duration: Duration(milliseconds: 3000),
                      ));
                    }
                  },
                  color: Colors.green,
                  text: 'Login',
                  width: width * 0.9,
                ),
              ],
            ),
            titlePadding: const EdgeInsets.all(16),
            contentPadding: const EdgeInsets.all(16),
            barrierDismissible: false,
            onWillPop: willPopCallback,
          );
        });
      } on FirebaseAuthException {
        Get.showSnackbar(const GetSnackBar(
          backgroundColor: Colors.red,
          message: "Your Entered OTP is Invalid",
          duration: Duration(milliseconds: 3000),
        ));
      }
    }

    final otpField = OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width - 45,
      outlineBorderRadius: 10,
      fieldWidth: ((MediaQuery.of(context).size.width) / 8) - 2,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: Colors.grey.shade50,
        enabledBorderColor: Colors.blueGrey.shade200,
        borderColor: Colors.purple.shade300,
        focusBorderColor: Colors.purple.shade800,
      ),
      style: const TextStyle(
          fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xff003a00)),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.box,
      onChanged: (pin) {},
      onCompleted: (pin) {
        if (pin.length == 6) {
          verifyOTP(pin);
        } else {
          Get.showSnackbar(const GetSnackBar(
            backgroundColor: Colors.red,
            message: "Your Entered OTP is Invalid",
            duration: Duration(milliseconds: 3000),
          ));
        }
      },
    );

    void signIn() async {
      await _auth.verifyPhoneNumber(
          phoneNumber: "+91${mobile.text}",
          timeout: const Duration(seconds: 120),
          verificationCompleted: (PhoneAuthCredential credential) async {},
          verificationFailed: (FirebaseAuthException exeption) async {
            setState(() {
              isLoading = false;
            });
            Get.showSnackbar(GetSnackBar(
              backgroundColor: Colors.red,
              message: exeption.message.toString(),
              duration: const Duration(milliseconds: 3000),
            ));
          },
          codeSent: (String vericationID, int? resendToken) async {
            verificationIDR = vericationID;
            setState(() {
              isLoading = false;
            });
            Get.defaultDialog(
                title: "Verification",
                content: otpField,
                titlePadding: const EdgeInsets.all(16),
                contentPadding: const EdgeInsets.all(16),
                barrierDismissible: false,
                onWillPop: willPopCallback);

            Get.showSnackbar(const GetSnackBar(
              backgroundColor: Colors.green,
              message: "OTP Sent to Your Number",
              duration: Duration(milliseconds: 3000),
            ));
          },
          codeAutoRetrievalTimeout: (String verificationID) async {
            setState(() {
              isLoading = false;
            });
          });
    }

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xff003a00),
    ));
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

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
                          height: height * 0.1,
                        ),
                        Image.asset(
                          'assets/new_logo.jpeg',
                          scale: 6,
                        ),
                        SizedBox(
                          height: height * 0.07,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Forgot Password',
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
                          hintText: 'Mobile number',
                          textInputType: TextInputType.number,
                          obscure: false,
                          controller: mobile,
                        ),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        CommonButton(
                          onTap: () {
                            if (mobile.text.length == 10) {
                              signIn();
                              setState(() {
                                isLoading = true;
                              });
                            } else {
                              Get.showSnackbar(const GetSnackBar(
                                backgroundColor: Colors.red,
                                message: "Password should be 8 characters long",
                                duration: Duration(milliseconds: 3000),
                              ));
                            }
                          },
                          color: Colors.green,
                          text: 'Send Otp',
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
