import 'package:flutter/material.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {

  dynamic height,width;

  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: const Color(0xff003a00),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logo_temple.jpeg',scale: 10,fit: BoxFit.cover,),
          ),
          title: Image.asset('assets/logo_name.jpeg',scale: 5,),
          centerTitle: true,
        ),
      body: SizedBox(
        height: height,
        width: width,
        child: ListView.builder(
          itemCount: 10,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context,index){
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xffeed06e).withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(-1,1)
                    )
                  ]
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      SizedBox(
                        height: height*0.25,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset('assets/banner.jpg',fit: BoxFit.fill,),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.bookmark,color: Colors.white,),
                      )
                    ],
                  ),
                  const SizedBox(height: 10,),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('Janmashtami Shri Krishna Abhishek, Bhog and Maha Aart'),
                  ),
                  const SizedBox(height: 10,),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('24 Aug 2022',style: TextStyle(color: Colors.grey,fontSize: 12),),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('3 likes',style: TextStyle(color: Colors.black,fontSize: 13),),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('3 Comment',style: TextStyle(color: Colors.black,fontSize: 13),),
                      ),
                    ],
                  ),
                  const Divider(endIndent: 10,indent: 10,),
                  const SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: width*0.25,
                        height: height*0.05,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.thumb_up_alt_outlined),
                            SizedBox(width: 10,),
                            Text('Like',style: TextStyle(color: Colors.black,fontSize: 12),),
                          ],
                        ),
                      ),
                      Container(
                        height: height*0.05,
                        width: 1,
                        color: Colors.grey,
                      ),
                      Container(
                        width: width*0.3,
                        height: height*0.05,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.comment),
                            SizedBox(width: 10,),
                            Text('Comment',style: TextStyle(color: Colors.black,fontSize: 12),),
                          ],
                        ),
                      ),
                      Container(
                        height: height*0.05,
                        width: 1,
                        color: Colors.grey,
                      ),
                      Container(
                        width: width*0.3,
                        height: height*0.05,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.share),
                            SizedBox(width: 10,),
                            Text('Share',style: TextStyle(color: Colors.black,fontSize: 12),),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                ],
              ),
            );
          },
        )
      )
    );
  }
}
