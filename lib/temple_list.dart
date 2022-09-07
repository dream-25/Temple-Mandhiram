import 'package:flutter/material.dart';

class TempleListScreen extends StatefulWidget {
  const TempleListScreen({Key? key}) : super(key: key);

  @override
  _TempleListScreenState createState() => _TempleListScreenState();
}

class _TempleListScreenState extends State<TempleListScreen> {

  dynamic height,width;

  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.grey.shade100,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back,color: Colors.black,),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Colors.grey.shade100,
              title: const Text('Temple List',style: TextStyle(color: Colors.black),),
              bottom: TabBar(
                labelColor: Colors.green,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.green,
                tabs: [
                  Tab(text: 'All Gods',icon: Image.asset('assets/ohm_prev_ui.png',scale: 12,),),
                  Tab(text: 'Ganesha',icon: Image.asset('assets/ganeshji_prev_ui.png',scale: 12,),),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 10,),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('500 Homes in India',style: TextStyle(color: Colors.grey,fontSize: 13),),
                            Container(
                              height: height*0.04,
                              width: width*0.3,
                              color: const Color(0xff003a00),
                              child: const Center(
                                child: Text('States',style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        itemCount: 10,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          return GestureDetector(
                            onTap: (){
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => const BlogDetailScreen()));
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                // color: const Color(0xffeed06e).withOpacity(0.5),
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0xffeed06e).withOpacity(0.4),
                                      blurRadius: 2,
                                      spreadRadius: 2,
                                      offset: const Offset(-2,2)
                                  )
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: height*0.15,
                                    width: width*0.3,
                                    color: Colors.green,
                                    child: Image.asset('assets/temp.png',fit: BoxFit.fill,),
                                  ),
                                  const SizedBox(width: 10,),
                                  SizedBox(
                                    height: height*0.15,
                                    width: width*0.53,
                                    // color: Colors.green,
                                    child: const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis',
                                      maxLines: 5,overflow: TextOverflow.ellipsis,),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 10,),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('500 Homes in India',style: TextStyle(color: Colors.grey,fontSize: 13),),
                            Container(
                              height: height*0.04,
                              width: width*0.3,
                              color: const Color(0xff003a00),
                              child: const Center(
                                child: Text('States',style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        itemCount: 10,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          return GestureDetector(
                            onTap: (){
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => const BlogDetailScreen()));
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                // color: const Color(0xffeed06e).withOpacity(0.5),
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0xffeed06e).withOpacity(0.4),
                                      blurRadius: 2,
                                      spreadRadius: 2,
                                      offset: const Offset(-2,2)
                                  )
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: height*0.15,
                                    width: width*0.3,
                                    color: Colors.green,
                                    child: Image.asset('assets/temp.png',fit: BoxFit.fill,),
                                  ),
                                  const SizedBox(width: 10,),
                                  SizedBox(
                                    height: height*0.15,
                                    width: width*0.53,
                                    // color: Colors.green,
                                    child: const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis',
                                      maxLines: 5,overflow: TextOverflow.ellipsis,),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
