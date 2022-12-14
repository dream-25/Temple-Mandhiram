import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temple_mandhiram/25drmcodes/models/familymodel.dart';
import 'package:temple_mandhiram/25drmcodes/models/profilemodel.dart';

import '../constants/app_constants.dart';

class ProfileController extends GetxController {
  var userName = TextEditingController();
  var isUpdateProfileLoading = false.obs;

  var profileModel = ProfileModel().obs;
  var familyModel = FamilyModel().obs;
  var isLoading = false.obs;
  void getProfileData() async {
    var dio = Dio();
    dio.options.headers["authUser"] = getBox.read(userToken);
    await dio.get("$BASEURL/api/user/fetch").then((value) {
      profileModel.update((val) async {
        profileModel = ProfileModel.fromJson(value.data).obs;
        userName.text = profileModel.value.message!.name!;
      });
    });
  }

  void getFamilyData() async {
    var dio = Dio();
    dio.options.headers["authUser"] = getBox.read(userToken);
    var result = await dio.get("$BASEURL/api/user/family");
    familyModel.update((val) {
      familyModel = FamilyModel.fromJson(result.data).obs;
    });
  }
}
