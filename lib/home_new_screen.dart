import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:temple_mandhiram/temple_detail.dart';

class HomeNewScreen extends StatefulWidget {
  const HomeNewScreen({Key? key}) : super(key: key);

  @override
  _HomeNewScreenState createState() => _HomeNewScreenState();
}

class _HomeNewScreenState extends State<HomeNewScreen> {
  dynamic height, width;
  int current = 0;
  final CarouselController _controller = CarouselController();
  List list = [
    'assets/banner.jpg',
    'assets/banner.jpg',
    'assets/banner.jpg',
    'assets/banner.jpg',
  ];

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
          child: Image.asset(
            'assets/logo_temple.jpeg',
            scale: 10,
            fit: BoxFit.cover,
          ),
        ),
        title: Image.asset(
          'assets/logo_name.jpeg',
          scale: 5,
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              /*SizedBox(height: height*0.02,),
              Column(
                children: [
                  Container(
                    height: height*0.2,
                    child: CarouselSlider(
                      options: CarouselOptions(
                          aspectRatio: 2, height: 300,
                          autoPlay: true,
                          viewportFraction: 1,onPageChanged: (index, reason) {
                        setState(() {
                          current = index;
                        });
                      }),
                      items: list.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return InkWell(
                              onTap: (){
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => const CategoryProduct(name: "Category Name",)));
                              },
                              child: Container(
                                width: width,
                                margin: const EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    image: AssetImage(i),
                                    fit: BoxFit.fill
                                  )
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: height*0.12,
                                      width: width*0.5,
                                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                      child: const Text('JYOTIRILINGA MAMLESHWAR,OMKARSHWAR',maxLines: 4,style: TextStyle(
                                        fontWeight: FontWeight.w600,fontSize: 15,color: Colors.white
                                      ),),
                                    ),
                                    Container(
                                      height: height*0.05,
                                      width: width*0.33,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                      child: const Center(child: Text('AUG 25,2022',style: TextStyle(
                                          fontWeight: FontWeight.w600,fontSize: 13,color: Colors.white
                                      )),),
                                    )
                                  ],
                                )
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: list.asMap().entries.map((entry) {
                      return InkWell(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: current == entry.key ? 10 : 6,
                          height: current == entry.key ?10 : 6,
                          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness == Brightness.dark
                                  ?  Colors.white
                                  : const Color(0xff003a00)).withOpacity(current == entry.key ? 1 : 0.5)),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: height*0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TempleListScreen()));
                    },
                    child: block('assets/temp_icon.png', 'Temple',14.0),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PujaListScreen()));
                    },
                    child: block('assets/puja.png', 'Puja',5.0),
                  )
                ],
              ),*/
              SizedBox(
                height: height * 0.03,
              ),
              /*const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text('Recent Puja Conducted',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
                ),
              ),
              SizedBox(height: height*0.02,),*/
              ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TempleDetail()));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0xffeed06e).withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(-1, 1))
                          ]),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              SizedBox(
                                height: height * 0.25,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/banner.jpg',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.bookmark,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'Temple Name',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                                'Janmashtami Shri Krishna Abhishek, Bhog and Maha Aart'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: width * 0.08,
                                      height: height * 0.07,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/travel.jpg',
                                            scale: 10,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            '1',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      height: height * 0.05,
                                      width: 1,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      width: width * 0.08,
                                      height: height * 0.07,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/hotel.png',
                                            scale: 10,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            '1',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      height: height * 0.05,
                                      width: 1,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      width: width * 0.08,
                                      height: height * 0.07,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/puja.png',
                                            scale: 6,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            '1',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      height: height * 0.05,
                                      width: 1,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      width: width * 0.08,
                                      height: height * 0.07,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/blue.png',
                                            scale: 10,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            '1',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      height: height * 0.05,
                                      width: 1,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                                Container(
                                  width: width * 0.3,
                                  height: height * 0.04,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                            color: const Color(0xff000000)
                                                .withOpacity(0.1),
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: const Offset(-2, 2))
                                      ]),
                                  child: const Center(
                                    child: Text(
                                      'Share this',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  block(image, text, scale) {
    return Container(
      height: height * 0.07,
      width: width * 0.4,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: const Color(0xffeed06e).withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(-2, 2))
          ]),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, scale: scale, color: const Color(0xff003a00)),
            const SizedBox(
              width: 10,
            ),
            Text(text,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
