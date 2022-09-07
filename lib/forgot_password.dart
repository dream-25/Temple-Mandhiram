import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Common/common_button.dart';
import 'Common/common_text_field.dart';
import 'otp.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  dynamic height, width;
  TextEditingController mobile = TextEditingController();
  TextEditingController pass = TextEditingController();

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
            // decoration: const BoxDecoration(
            //     image: DecorationImage(
            //         image: AssetImage('assets/temp.png',),
            //         fit: BoxFit.fill
            //     )
            // ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.1,
                      ),
                      // Text('Welcome to our Temple APP',
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //   color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold
                      // ),),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const OtpScreen()));
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
        ));
  }
}
