import 'package:flutter/material.dart';
// import 'package:fireflutterfloder/enter/login.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
      appBar: AppBar(

        title: Text("RailWay +",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
                color: Colors.white
            )
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pushNamed(context, '/login');
          },
            child:Row(
              children: [
                Icon(Icons.login_outlined,color: Colors.white,),
                SizedBox(width: 8,),
                Text("LogIn",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,

                  ),),

              ],
            ),
          )
        ],
        backgroundColor: Colors.deepPurple[800],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            )
        ),

      ),
      body: Center(
        child: Column(
          children: [
            Image.asset('assest/Logomain.png'),
            SizedBox(height: 25,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              height: 250,

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
                            child: IconButton(onPressed: (){}, icon: Icon(Icons.train_outlined,color: Colors.blue,size: 40,)),
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white70,

                            ),
                          ),
                          Text("Train",style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),),
                        ],
                      ),

                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                            child: IconButton(onPressed: (){}, icon: Icon(Icons.book_online_outlined,size: 40,color: Colors.green,)),
                            height: 60,
                            width: 60,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white70,
                            ),
                          ),
                          Text("PNR status",style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),)
                        ],
                      ),

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
                          Text("Live status",style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),)
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
                            child: IconButton(onPressed: (){}, icon: Icon(Icons.newspaper_outlined,size: 40,color: Colors.orange,)),
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

                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                            child: IconButton(onPressed: (){}, icon: Icon(Icons.person,color: Colors.green,size:40, )),
                            height: 60,
                            width: 60,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white70,
                            ),
                          ),
                          Text("Manager",style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),)
                        ],
                      ),

                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                            // child: IconButton(onPressed: (){}, icon: Icon(Icons.directions_car_filled_outlined,color: Colors.pink,size:40, )),
                            height: 60,
                            width: 60,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white70,
                            ),
                          ),
                          // Text("Buggy",style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),)
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
    ),);
  }
}
