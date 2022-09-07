import 'package:flutter/material.dart';

class CommonButton extends StatefulWidget {
  String text;
  dynamic width;
  Color color;
  Function onTap;
  CommonButton(
      {Key? key,
      required this.text,
      this.width,
      required this.color,
      required this.onTap})
      : super(key: key);

  @override
  _CommonButtonState createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  dynamic height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: Container(
          height: height * 0.07,
          width: widget.width,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          // alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: widget.color),
          child: Center(
            child: Text(
              widget.text,
              style: const TextStyle(color: Colors.white, fontSize: 17),
            ),
          )),
    );
  }
}
