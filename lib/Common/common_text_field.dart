// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';

class CommonTextField extends StatefulWidget {
  TextEditingController? controller;
  bool? obscure;
  String? hintText;
  TextInputType? textInputType;
  bool? enabled;

  CommonTextField(
      {Key? key,
      this.obscure,
      this.textInputType,
      this.controller,
      this.hintText,
      this.enabled})
      : super(key: key);

  @override
  _CommonTextFieldState createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  dynamic height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.07,
      width: width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscure!,
        obscuringCharacter: '*',
        enabled: widget.enabled,
        keyboardType: widget.textInputType,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}
