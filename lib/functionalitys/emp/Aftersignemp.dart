import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../enter/home.dart';
class Aftersiginemp extends StatefulWidget {
  const Aftersiginemp({super.key});

  @override
  State<Aftersiginemp> createState() => _AftersiginempState();
}

class _AftersiginempState extends State<Aftersiginemp> {
  late String imageurl;
  final _auth=FirebaseAuth.instance;
  final _storage=FirebaseStorage.instance;
  @override
  void initState(){
    super.initState();
    imageurl='';
    getImageUrl();
  }

  Future<void>getImageUrl()async{
    User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      final ref=_storage.ref().child(uid);
      final url=await ref.getDownloadURL();
      setState(() {
        imageurl=url;
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[800],
          title: Text("RailWay +",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25.0,),
          ),
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )
          ),

        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(child:
              imageurl !=null?
              CircleAvatar(
                backgroundImage: NetworkImage(imageurl),
                radius: 90.0,
              ):
              CircleAvatar(
                backgroundImage: AssetImage('assest/default.jpg'),
                radius: 90.0,
              )
              ),
              ListTile(
                title: TextButton(onPressed: (){
                  Navigator.pushNamed(context, '/aftersigemp');
                },
                  child:Row(
                    children: [
                      Icon(Icons.home_outlined,
                        color: Colors.black,),
                      SizedBox(width: 10,),
                      Text("Home",
                        style: TextStyle(
                          color: Colors.black,

                          fontSize: 20.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                title:  TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/profile');
                  },
                  child:Row(
                    children: [
                      Icon(Icons.person,
                        color: Colors.black,),
                      SizedBox(width: 10,),
                      Text("Profile",
                        style: TextStyle(
                          color: Colors.black,

                          fontSize: 20.0,
                        ),
                      )
                    ],
                  ),
                ),

              ),
              ListTile(
                title: TextButton(onPressed: (){

                },
                  child:Row(
                    children: [
                      Icon(Icons.book_online_outlined,
                        color: Colors.black,),
                      SizedBox(width: 10,),
                      Text("Buggy Service",
                        style: TextStyle(
                          color: Colors.black,

                          fontSize: 20.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                title: TextButton(onPressed: (){

                },
                  child:Row(
                    children: [
                      Icon(Icons.cancel_outlined,
                        color: Colors.black,),
                      SizedBox(width: 10,),
                      Text("Luggage service",
                        style: TextStyle(
                          color: Colors.black,

                          fontSize: 20.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),

              ListTile(
                title: TextButton(
                  onPressed: () async{
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacement(

                        MaterialPageRoute(builder: ((context) => Home())));

                  },
                  child:Row(
                    children: [
                      Icon(Icons.logout_outlined,
                        color: Colors.black,),
                      SizedBox(width: 10,),
                      Text("Sign out",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),



            ],
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
              margin: const EdgeInsets.symmetric(horizontal: 30),
              height: 125,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.deepPurple[200],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                            child: IconButton(onPressed: (){Navigator.pushNamed(context, '/luggageemp');}, icon: Icon(Icons.luggage_outlined,color: Colors.blue,size: 40,)),
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white70,

                            ),
                          ),
                          Text("Luaggege",style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),),
                        ],
                      ),
                      SizedBox(width: 35,),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                            child: IconButton(onPressed: (){Navigator.pushNamed(context, '/buggyemp');}, icon: Icon(Icons.car_rental_outlined,size: 40,color: Colors.green,)),
                            height: 60,
                            width: 60,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white70,
                            ),
                          ),
                          Text("Buggy",style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),)
                        ],
                      ),


                    ],
                  )
                ],
              ),

            )
          ],
        ),
        ),
      ),
      ),
    );
  }
}
