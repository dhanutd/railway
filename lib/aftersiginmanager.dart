import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:railway/enter/home.dart';
class Aftersiginmanager extends StatefulWidget {
  const Aftersiginmanager({super.key});

  @override
  State<Aftersiginmanager> createState() => _AftersiginmanagerState();
}

class _AftersiginmanagerState extends State<Aftersiginmanager> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[800],
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("RailWay +",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,),
                  ),
                  IconButton(onPressed: ()async{
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacement(

                        MaterialPageRoute(builder: ((context) => Home())));
                  }, icon: Icon(Icons.logout_outlined,color: Colors.white,))
                ],
              )
            ],
          ),
          automaticallyImplyLeading: false,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )
          ),

        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                Image.asset('assest/Logomain.png'),
                SizedBox(height: 25,),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  height: 120,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.deepPurple[200],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                child: IconButton(onPressed: (){Navigator.pushNamed(context, '/stationinfo');}, icon: Icon(Icons.train_rounded,color: Colors.blue,size: 40,)),
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white70,

                                ),
                              ),
                              Text("Station \nInformation",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),),
                            ],
                          ),
                          SizedBox(width: 35,),
                          Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                child: IconButton(onPressed: (){Navigator.pushNamed(context, '/stationnews');}, icon: Icon(Icons.newspaper_outlined,size: 40,color: Colors.black,)),
                                height: 60,
                                width: 60,

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white70,
                                ),
                              ),
                              Text("news \n Update",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),)
                            ],
                          ),
                          SizedBox(width: 35,),
                          Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                child: IconButton(onPressed: (){}, icon: Icon(Icons.location_on_outlined,size: 40,color: Colors.red,)),
                                height: 60,
                                width: 60,

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white70,
                                ),
                              ),
                              Text("Live Status\n Update",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),)
                            ],
                          ),
                        ],
                      ),

                    ],
                  ),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
