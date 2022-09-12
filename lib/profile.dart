// ignore_for_file: library_private_types_in_public_api

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temple_mandhiram/25drmcodes/models/familymodel.dart';
import 'package:temple_mandhiram/Common/common_text_field.dart';
import 'package:temple_mandhiram/add_family_member.dart';

import '25drmcodes/constants/app_constants.dart';
import '25drmcodes/models/profilemodel.dart';
import 'Common/common_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  dynamic height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    Future<ProfileModel> profileData() async {
      var dio = Dio();
      dio.options.headers["authUser"] = getBox.read(userToken);
      var result = await dio.get("$BASEURL/api/user/fetch");
      return ProfileModel.fromJson(result.data);
    }

    Future<FamilyModel> familyData() async {
      var dio = Dio();
      dio.options.headers["authUser"] = getBox.read(userToken);
      var result = await dio.get("$BASEURL/api/user/family");
      return FamilyModel.fromJson(result.data);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: FutureBuilder(
            future: profileData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data != null) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            dynamic height, width;
                            TextEditingController mobile =
                                TextEditingController();
                            TextEditingController name =
                                TextEditingController();
                            TextEditingController dob = TextEditingController();
                            var isLoading = false;
                            mobile.text = snapshot.data!.message!.phone!;
                            name.text = snapshot.data!.message!.name!;
                            dob.text =
                                "${snapshot.data!.message!.birthDate!.year}-${snapshot.data!.message!.birthDate!.month}-${snapshot.data!.message!.birthDate!.day}";

                            Future<void> selectDate(
                                BuildContext context) async {
                              final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900, 8),
                                  lastDate: DateTime(2101));
                              if (picked != null) {
                                dob.text =
                                    "${picked.year}-${picked.month}-${picked.day}";
                              }
                            }

                            void updateUser() {}
                            height = Get.height;
                            width = Get.width;
                            Get.dialog(Scaffold(
                                backgroundColor: const Color(0xff003a00),
                                body: SafeArea(
                                    child: Stack(
                                  children: [
                                    SingleChildScrollView(
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
                                          InkWell(
                                            onTap: () => selectDate(context),
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
                                          SizedBox(
                                            height: height * 0.04,
                                          ),
                                          CommonButton(
                                            onTap: () {
                                              if (name.text.length > 3) {
                                                if (mobile.text.length == 10) {
                                                  if (dob.text.isNotEmpty) {
                                                    updateUser();
                                                    setState(() {
                                                      isLoading = true;
                                                    });
                                                  } else {
                                                    Get.showSnackbar(
                                                        const GetSnackBar(
                                                      backgroundColor:
                                                          Colors.red,
                                                      message:
                                                          "Please enter a valid DOB",
                                                      duration: Duration(
                                                          milliseconds: 3000),
                                                    ));
                                                  }
                                                } else {
                                                  Get.showSnackbar(
                                                      const GetSnackBar(
                                                    backgroundColor: Colors.red,
                                                    message:
                                                        "Please enter a valid Number",
                                                    duration: Duration(
                                                        milliseconds: 3000),
                                                  ));
                                                }
                                              } else {
                                                Get.showSnackbar(
                                                    const GetSnackBar(
                                                  backgroundColor: Colors.red,
                                                  message:
                                                      "Please enter a valid Name",
                                                  duration: Duration(
                                                      milliseconds: 3000),
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
                                ))));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data!.message!.name!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'Me',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              const Text(
                                'Edit',
                                style: TextStyle(
                                    fontSize: 13,
                                    decoration: TextDecoration.underline,
                                    color: Color(0xff003a00)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AddFamilyScreen()));
                          },
                          child: Row(
                            children: const [
                              Icon(Icons.add_circle_outline),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Add Your Family Member',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 15,
                        ),
                        FutureBuilder<FamilyModel>(
                          future: familyData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.data != null) {
                              return ListView.builder(
                                  itemCount: snapshot.data!.message!.length,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: ListTile(
                                        onTap: () {
                                          var name = snapshot
                                              .data!.message![index].name!;
                                          var birthDate = snapshot
                                              .data!.message![index].birthDate!;
                                          var gender = snapshot
                                              .data!.message![index].gender!;
                                          var relation = snapshot
                                              .data!.message![index].relation!;
                                          var location = snapshot
                                              .data!.message![index].location!;
                                          var gotra = snapshot
                                              .data!.message![index].gotra!;

                                          Get.defaultDialog(
                                              contentPadding:
                                                  const EdgeInsets.all(12),
                                              titlePadding:
                                                  const EdgeInsets.all(12),
                                              title: "Family Details",
                                              backgroundColor:
                                                  Colors.grey.shade300,
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    CommonTextField(
                                                      hintText: "Name: $name",
                                                      obscure: false,
                                                      enabled: false,
                                                    ),
                                                    SizedBox(
                                                        height: height * 0.01),
                                                    CommonTextField(
                                                      hintText:
                                                          "Birthdate: ${birthDate.year}-${birthDate.month}-${birthDate.day}",
                                                      obscure: false,
                                                      enabled: false,
                                                    ),
                                                    SizedBox(
                                                        height: height * 0.01),
                                                    CommonTextField(
                                                      hintText:
                                                          "Gender: $gender",
                                                      obscure: false,
                                                      enabled: false,
                                                    ),
                                                    SizedBox(
                                                        height: height * 0.01),
                                                    CommonTextField(
                                                      hintText:
                                                          "Relation: $relation",
                                                      obscure: false,
                                                      enabled: false,
                                                    ),
                                                    SizedBox(
                                                        height: height * 0.01),
                                                    CommonTextField(
                                                      hintText:
                                                          "Location: $location",
                                                      obscure: false,
                                                      enabled: false,
                                                    ),
                                                    SizedBox(
                                                        height: height * 0.01),
                                                    CommonTextField(
                                                      hintText: "Gotra: $gotra",
                                                      obscure: false,
                                                      enabled: false,
                                                    ),
                                                    SizedBox(
                                                        height: height * 0.01),
                                                  ],
                                                ),
                                              ));
                                        },
                                        leading: const Icon(Icons.person),
                                        title: Text(snapshot
                                            .data!.message![index].name!),
                                        trailing:
                                            const Icon(Icons.arrow_forward),
                                      ),
                                    );
                                  });
                            } else {
                              return Container(
                                alignment: Alignment.center,
                                child: const SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    color: COLORPRIMARYDARK,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Container(
                  alignment: Alignment.center,
                  child: const SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      color: COLORPRIMARYDARK,
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
