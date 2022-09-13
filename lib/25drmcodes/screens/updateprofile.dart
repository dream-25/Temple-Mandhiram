import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:temple_mandhiram/25drmcodes/constants/app_constants.dart';
import 'package:temple_mandhiram/25drmcodes/contollers/profilecontroller.dart';

import '../../Common/common_button.dart';
import '../../Common/common_text_field.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  var controller = Get.put(ProfileController());
  File? image;
  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    return Scaffold(
        backgroundColor: const Color(0xff003a00),
        appBar: AppBar(
          backgroundColor: const Color(0xff003a00),
          title: const Text('Update Profile'),
        ),
        body: SafeArea(
            child: Stack(
          children: [
            Obx(() {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.05,
                    ),
                    InkWell(
                      onTap: () async {
                        try {
                          var result = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);

                          if (result != null) {
                            setState(() {
                              image = File(result.path);
                            });
                          } else {
                            Get.showSnackbar(const GetSnackBar(
                              backgroundColor: Colors.red,
                              message: "Please select a File to upload",
                              duration: Duration(milliseconds: 3000),
                            ));
                          }
                        } on PlatformException catch (e) {
                          Get.showSnackbar(GetSnackBar(
                            backgroundColor: Colors.red,
                            message: "Failed: $e",
                            duration: const Duration(milliseconds: 3000),
                          ));
                        }
                      },
                      child: image == null
                          ? ((controller.profileModel.value.message == null ||
                                  controller
                                          .profileModel.value.message!.image! !=
                                      "")
                              ? CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 75,
                                  backgroundImage: CachedNetworkImageProvider(
                                      controller
                                          .profileModel.value.message!.image!),
                                )
                              : const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 75,
                                  backgroundImage:
                                      AssetImage('assets/person-icon.png'),
                                ))
                          : CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 75,
                              backgroundImage: FileImage(image!)),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    CommonTextField(
                      enabled: true,
                      hintText: 'Name',
                      textInputType: TextInputType.text,
                      obscure: false,
                      controller: controller.userName,
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    CommonButton(
                      onTap: () async {
                        if (controller.userName.text.length > 3) {
                          dio.FormData formData = dio.FormData.fromMap({
                            "image": await dio.MultipartFile.fromFile(
                                image!.path,
                                filename: image!.path.split('/').last,
                                contentType: MediaType('image', 'png')),
                            "name": controller.userName.text
                          });

                          var myDio = dio.Dio();
                          myDio.options.headers["authUser"] =
                              getBox.read(userToken);
                          myDio.options.headers["Content-Type"] =
                              "multipart/form-data";
                          await myDio
                              .put(
                            "$BASEURL/api/user/updateuser",
                            data: formData,
                            options: dio.Options(
                              validateStatus: (status) => true,
                            ),
                          )
                              .then((value) {
                            log(json.encode(value.data));
                          });
                        } else {
                          Get.showSnackbar(const GetSnackBar(
                            backgroundColor: Colors.red,
                            message: "Please enter a valid Name",
                            duration: Duration(milliseconds: 3000),
                          ));
                        }
                      },
                      color: Colors.green,
                      text: 'Update',
                      width: width * 0.9,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                  ],
                ),
              );
            }),
            Obx(() {
              return Visibility(
                visible: controller.isUpdateProfileLoading.value,
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
              );
            }),
          ],
        )));
  }
}
