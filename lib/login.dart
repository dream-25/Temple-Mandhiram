import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:temple_mandhiram/register.dart';

import 'Common/common_button.dart';
import 'Common/common_text_field.dart';
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
          child: SizedBox(
            height: height,
            width: width,
            // decoration: const BoxDecoration(
            //     image: DecorationImage(
            //         image: AssetImage('assets/temp.png',),
            //         fit: BoxFit.fill
            //     )
            // ),
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
                      onTap: () {},
                      color: Colors.green,
                      text: 'Login',
                      width: width * 0.9,
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
                                builder: (context) => const RegisterScreen()));
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
                                  TextStyle(color: Colors.green, fontSize: 17)),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
