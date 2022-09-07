import 'package:flutter/material.dart';

class PujaListScreen extends StatefulWidget {
  const PujaListScreen({Key? key}) : super(key: key);

  @override
  _PujaListScreenState createState() => _PujaListScreenState();
}

class _PujaListScreenState extends State<PujaListScreen> {

  dynamic height,width;

  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.grey.shade100,
        title: const Text('Puja',style: TextStyle(color: Colors.black),),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                return InkWell(
                  onTap: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const CategoryProduct(name: "Category Name",)));
                  },
                  child: Container(
                      width: width,
                      margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: const DecorationImage(
                              image: AssetImage('assets/banner.jpg'),
                              fit: BoxFit.fill
                          ),
                          boxShadow: [
                            BoxShadow(
                                color:Colors.grey.shade200,
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(-2,2)
                            )
                          ]
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
            ),
          ),
        ),
      ),
    );
  }
}
