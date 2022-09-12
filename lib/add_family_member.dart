// ignore_for_file: library_private_types_in_public_api

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temple_mandhiram/25drmcodes/constants/app_constants.dart';

import 'Common/common_button.dart';
import 'Common/common_text_field.dart';

class AddFamilyScreen extends StatefulWidget {
  const AddFamilyScreen({Key? key}) : super(key: key);

  @override
  _AddFamilyScreenState createState() => _AddFamilyScreenState();
}

class _AddFamilyScreenState extends State<AddFamilyScreen> {
  dynamic height, width;
  TextEditingController name = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController gotra = TextEditingController();

  var isLoading = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 8),
      lastDate: DateTime.now(),
    );
    if (picked != null &&
        (DateTime.now().millisecondsSinceEpoch -
                picked.millisecondsSinceEpoch) >
            410240376000) {
      dob.text = "${picked.year}-${picked.month}-${picked.day}";
    } else {
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: "You have to be atleast 13 years old",
        duration: Duration(milliseconds: 3000),
      ));
    }
  }

  void addFamilyMember() async {
    setState(() {
      isLoading = true;
    });

    var dio = Dio();
    var body = {
      "name": name.text.toString(),
      "birthDate": dob.text,
      "gender": genderSelected,
      "relation": relationSelected,
      "location": location.text.toString(),
      "gotra": gotra.text,
    };
    dio.options.headers["authUser"] = getBox.read(userToken);
    await dio
        .post("$BASEURL/api/user/family",
            data: body,
            options: Options(
              validateStatus: (status) => true,
            ))
        .then((value) {
      setState(() {
        isLoading = false;
      });
      if (value.statusCode == 200) {
        Get.showSnackbar(const GetSnackBar(
          backgroundColor: Colors.green,
          message: "Family Member Added",
          duration: Duration(milliseconds: 3000),
        ));
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: value.data["message"],
          duration: const Duration(milliseconds: 3000),
        ));
      }
    });
  }

  // ignore: prefer_typing_uninitialized_variables
  var genderSelected, relationSelected;
  List gender = ['Male', 'Female', 'Other'];
  List relation = ['Me', 'Wife', 'Husband', 'Father', 'Mother', 'Other'];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.green,
          title: const Text('Add Family Member'),
          centerTitle: true,
        ),
        body: Stack(children: [
          SizedBox(
            height: height,
            width: width,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
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
                  Container(
                      height: height * 0.07,
                      width: width * 0.9,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: genderSelected,
                          hint: const Text(
                            'Gender',
                            style: TextStyle(color: Colors.grey),
                          ),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: gender.map((items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (newValue) {
                            setState(() {
                              genderSelected = newValue!;
                            });
                          },
                        ),
                      )),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Container(
                      height: height * 0.07,
                      width: width * 0.9,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: relationSelected,
                          hint: const Text(
                            'Relation',
                            style: TextStyle(color: Colors.grey),
                          ),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: relation.map((items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              relationSelected = newValue!;
                            });
                          },
                        ),
                      )),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  CommonTextField(
                    enabled: true,
                    hintText: 'Current Location',
                    textInputType: TextInputType.text,
                    obscure: false,
                    controller: location,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  CommonTextField(
                    enabled: true,
                    hintText: 'Gotra',
                    textInputType: TextInputType.text,
                    obscure: false,
                    controller: gotra,
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  CommonButton(
                    onTap: () async {
                      if (name.text.length > 3) {
                        if (dob.text.isNotEmpty) {
                          if (genderSelected != null) {
                            if (relationSelected != null) {
                              if (location.text.length > 3) {
                                if (gotra.text.length > 2) {
                                  addFamilyMember();
                                } else {
                                  Get.showSnackbar(const GetSnackBar(
                                    backgroundColor: Colors.red,
                                    message: "Please Enter a Valid Gotra",
                                    duration: Duration(milliseconds: 3000),
                                  ));
                                }
                              } else {
                                Get.showSnackbar(const GetSnackBar(
                                  backgroundColor: Colors.red,
                                  message: "Please Enter a Valid Location",
                                  duration: Duration(milliseconds: 3000),
                                ));
                              }
                            } else {
                              Get.showSnackbar(const GetSnackBar(
                                backgroundColor: Colors.red,
                                message: "Please Select Relation",
                                duration: Duration(milliseconds: 3000),
                              ));
                            }
                          } else {
                            Get.showSnackbar(const GetSnackBar(
                              backgroundColor: Colors.red,
                              message: "Please Select Gender",
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
                          message: "Please enter a valid Name",
                          duration: Duration(milliseconds: 3000),
                        ));
                      }
                    },
                    color: const Color(0xff003a00),
                    text: 'Add',
                    width: width * 0.9,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                ],
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
        ]));
  }
}
