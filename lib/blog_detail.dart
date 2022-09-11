// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class BlogDetailScreen extends StatefulWidget {
  const BlogDetailScreen({Key? key}) : super(key: key);

  @override
  _BlogDetailScreenState createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  dynamic height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: height,
          width: width,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.35,
                  width: width,
                  child: Image.asset(
                    'assets/temp.png',
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Text(
                      'Lorem ipsum dolor sit amet. Vel dignissimos obcaecati est delectus omnis At soluta obcaecati ut saepe nobis in consequatur maiores id amet omnis sed magnam optio. Ea dolorum accusantium quo repellendus quod aut galisum rerum est facilis nesciunt sit voluptatem quas et maxime voluptatem aut repellendus nobis. Et libero blanditiis ea galisum velit qui atque omnis. Doloremque nesciunt aut tempora similique non nulla reprehenderit et ducimus magni.\n\nId enim odio eos ipsam voluptatem qui accusantium aliquid qui quia quia hic sunt impedit ea dolorum reprehenderit? Hic aliquid velit sed soluta error ut modi nobis est neque vitae qui autem voluptatem eos saepe neque ut reiciendis possimus. Quo quam optio ut enim provident et facere fuga et omnis esse et optio ipsa et dignissimos ipsum sit voluptatem iste.\n\nSed obcaecati inventore qui ipsam illo et rerum consectetur est omnis nesciunt sit natus rerum et quam eius? At doloribus quos aspernatur repudiandae aut atque voluptas et tenetur voluptas. Et ipsa neque est molestiae laborum nam odit nulla id impedit voluptatum. 33 quod accusantium At accusantium quia cum aperiam tempore non itaque animi aut Quis vitae aut quaerat provident.'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
