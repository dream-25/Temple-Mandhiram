// ignore_for_file: library_private_types_in_public_api

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:temple_mandhiram/25drmcodes/constants/app_constants.dart';
import 'package:temple_mandhiram/register.dart';

import 'Common/common_button.dart';
import 'Common/common_text_field.dart';
import 'dashboard.dart';
import 'forgot_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  dynamic height, width;
  TextEditingController mobile = TextEditingController();
  TextEditingController pass = TextEditingController();
  var isLoading = false;
  void loginAPi(String mobile, String pass) async {
    setState(() {
      isLoading = true;
    });

    var dio = Dio();
    var body = {
      "phone": mobile,
      "isVerified": true,
    };
    dio.options.headers["authTemple"] = authToken;
    await dio
        .put("$BASEURL/api/user/update",
            data: body,
            options: Options(
              validateStatus: (status) => true,
            ))
        .then((value) async {
      setState(() {
        isLoading = false;
      });
      if (value.statusCode == 200) {
        var dio = Dio();
        var body = {"phone": mobile, "password": pass};
        dio.options.headers["authTemple"] = authToken;
        await dio
            .post("$BASEURL/api/user/login",
                data: body,
                options: Options(
                  validateStatus: (status) => true,
                ))
            .then((value) {
          setState(() {
            isLoading = false;
          });
          if (value.statusCode == 200) {
            getBox.write(userToken, value.data["authUser"]);
            getBox.write(isUserLoggedIn, true);
            getBox.write(userNumber, mobile);

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
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: value.data["message"],
          duration: const Duration(milliseconds: 3000),
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
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
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
                          'Login',
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
                        height: height * 0.01,
                      ),
                      InkWell(
                        onTap: () {
                          // signInProvider.clearSignUpData();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen()));
                        },
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                                color: Colors.white54,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      CommonButton(
                        onTap: () {
                          (mobile.text.length > 9 && pass.text.length > 2)
                              ? loginAPi(
                                  mobile.text.toString(), pass.text.toString())
                              : Get.showSnackbar(const GetSnackBar(
                                  backgroundColor: Colors.red,
                                  message:
                                      "Please enter a valid Number and Password",
                                  duration: Duration(milliseconds: 3000),
                                ));
                        },
                        color: Colors.green,
                        text: 'Login',
                        width: width * 0.9,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             const RegisterScreen()));
                          Get.to(const RegisterScreen());
                        },
                        child: RichText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          text: const TextSpan(children: <TextSpan>[
                            TextSpan(
                              text: "Don’t have an account? ",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                            TextSpan(
                              text: "Sign Up",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 17),
                            ),
                          ]),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
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
