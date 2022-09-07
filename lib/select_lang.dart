import 'package:flutter/material.dart';

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({Key? key}) : super(key: key);

  @override
  _SelectLanguageState createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {

  int? value;
  dynamic height,width;

  List list = [
    'English','Hindi','Telugu'
  ];

  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.green,
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: ListView.builder(

          itemBuilder: (context, index) {
            return RadioListTile(
              value: index,
              groupValue: value,
              onChanged: (ind) => setState(() => value = ind as int?),
              title: Text(list[index]),
            );
          },
          itemCount: list.length,
        ),
      ),
    );
  }
}
