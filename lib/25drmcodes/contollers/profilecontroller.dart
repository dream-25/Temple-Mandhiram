import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:temple_mandhiram/25drmcodes/models/familymodel.dart';
import 'package:temple_mandhiram/25drmcodes/models/profilemodel.dart';

import '../constants/app_constants.dart';

class ProfileController extends GetxController {
  var profileModel = ProfileModel().obs;
  var familyModel = FamilyModel().obs;
  var isLoading = false.obs;
  void getProfileData() async {
    var dio = Dio();
    dio.options.headers["authUser"] = getBox.read(userToken);
    await dio.get("$BASEURL/api/user/fetch").then((value) {
      profileModel.update((val) {
        profileModel = ProfileModel.fromJson(value.data).obs;
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
