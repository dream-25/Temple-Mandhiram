import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Common/common_button.dart';
import 'Common/common_text_field.dart';
import 'dashboard.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  dynamic height,width;
  TextEditingController mobile = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController dob = TextEditingController();

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
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: height*0.05,),
                      // Text('Welcome to our Temple APP',
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //   color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold
                      // ),),
                      Image.asset('assets/new_logo.jpeg',scale: 6,),
                      SizedBox(height: height*0.04,),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Register',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold
                          ),),
                      ),
                      SizedBox(height: height*0.05,),
                      CommonTextField(
                        enabled: true,
                        hintText: 'Name',
                        textInputType: TextInputType.text,
                        obscure: false,
                        controller: name,
                      ),
                      SizedBox(height: height*0.03,),
                      CommonTextField(
                        enabled: true,
                        hintText: 'Mobile number',
                        textInputType: TextInputType.number,
                        obscure: false,
                        controller: mobile,
                      ),
                      SizedBox(height: height*0.03,),
                      CommonTextField(
                        enabled: true,
                        hintText: 'Date of Birth',
                        textInputType: TextInputType.text,
                        obscure: false,
                        controller: dob,
                      ),
                      SizedBox(height: height*0.03,),
                      CommonTextField(
                        enabled: true,
                        hintText: 'Password',
                        textInputType: TextInputType.text,
                        obscure: true,
                        controller: pass,
                      ),
                      SizedBox(height: height*0.04,),
                      CommonButton(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Dashboard()));
                        },
                        color: Colors.green,
                        text: 'Register',
                        width: width*0.9,
                      ),
                      SizedBox(height: height*0.01,),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );

  }

}
