import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../constants/app_constants.dart';
import '../models/templemodel.dart';

class TempleController extends GetxController {
  var templeModel = TempleModel().obs;

  templeData() async {
    var dio = Dio();
    dio.options.headers["authTemple"] = authToken;
    var result = await dio.get("$BASEURL/api/temple/fetchall");
    templeModel.update((val) {
      templeModel = TempleModel.fromJson(result.data).obs;
    });
  }
}
