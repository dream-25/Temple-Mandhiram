// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

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
      body: SizedBox(
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
              CommonTextField(
                enabled: true,
                hintText: 'Date of Birth',
                textInputType: TextInputType.text,
                obscure: false,
                controller: dob,
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
                controller: dob,
              ),
              SizedBox(
                height: height * 0.03,
              ),
              CommonTextField(
                enabled: true,
                hintText: 'Gotra',
                textInputType: TextInputType.text,
                obscure: false,
                controller: dob,
              ),
              SizedBox(
                height: height * 0.04,
              ),
              CommonButton(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
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
    );
  }
}
