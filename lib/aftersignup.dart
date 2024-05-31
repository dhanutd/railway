import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:railway/enter/home.dart';
import 'package:railway/functionalitys/Booking/My_booking.dart';
class aftersigup extends StatefulWidget {
  const aftersigup({super.key});

  @override
  State<aftersigup> createState() => _aftersigupState();
}

class _aftersigupState extends State<aftersigup> {
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
      print(url);
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
        title: Text("welcome",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25.0,),),
        backgroundColor: Colors.deepPurple,
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
                Navigator.pushNamed(context, '/aftersig');
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
                    Text("Booking",
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
                    Text("Cancle Ticket",
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
                    Icon(Icons.transfer_within_a_station_outlined,
                      color: Colors.black,),
                    SizedBox(width: 10,),
                    Text("Seat Transfer",
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
                    Icon(Icons.travel_explore_outlined,
                      color: Colors.black,),
                    SizedBox(width: 10,),
                    Text("Special services",
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
                    Icon(Icons.location_city_outlined,
                      color: Colors.black,),
                    SizedBox(width: 10,),
                    Text("Live status",
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
            ListTile(
              title: TextButton(onPressed: (){

              },
                child:Row(
                  children: [
                    Icon(Icons.book_outlined,
                      color: Colors.black,),
                    SizedBox(width: 10,),
                    Text("News",
                      style: TextStyle(
                        color: Colors.black,

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
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: 350,

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
                              child: IconButton(onPressed: (){Navigator.pushNamed(context, '/enterb');}, icon: Icon(Icons.train_outlined,color: Colors.blue,size: 40,)),
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white70,

                              ),
                            ),
                            Text("Booking",style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),),
                          ],
                        ),

                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                              child: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Mybooking()));}, icon: Icon(Icons.book_online_outlined,size: 40,color: Colors.green,)),
                              height: 60,
                              width: 60,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white70,
                              ),
                            ),
                            Text("My Booking",style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),)
                          ],
                        ),

                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                              child: IconButton(onPressed: (){}, icon: Icon(Icons.cancel_outlined,size: 40,color: Colors.red,)),
                              height: 60,
                              width: 60,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white70,
                              ),
                            ),
                            Text("Cancel",style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),)
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              child: IconButton(onPressed: (){}, icon: Icon(Icons.transfer_within_a_station_outlined,size: 40,color: Colors.orange,)),
                              height: 60,
                              width: 60,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white70,
                              ),
                            ),
                            Text("Seat Transfer",style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),)
                          ],
                        ),

                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                              child: IconButton(onPressed: (){}, icon: Icon(Icons.location_on_outlined,color: Colors.green,size:40, )),
                              height: 60,
                              width: 60,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white70,
                              ),
                            ),
                            Text("Live status",style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),)
                          ],
                        ),

                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                              child: IconButton(onPressed: (){Navigator.pushNamed(context, '/navib');}, icon: Icon(Icons.directions_car_filled_outlined,color: Colors.pink,size:40, )),
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
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              child: IconButton(onPressed: (){Navigator.pushNamed(context, '/navil');}, icon: Icon(Icons.luggage_outlined,color: Colors.purple,size:40, )),
                              height: 60,
                              width: 60,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white70,
                              ),
                            ),
                            Text("Luggage",style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),)
                          ],
                        ),

                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                              child: IconButton(onPressed: (){Navigator.pushNamed(context, '/usernews');}, icon: Icon(Icons.newspaper_outlined,color: Colors.black,size:40, )),
                              height: 60,
                              width: 60,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white70,
                              ),
                            ),
                            Text("News",style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),)
                          ],
                        ),

                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),

                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white70,
                          ),
                        )
                      ],
                    )
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
