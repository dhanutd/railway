import 'package:flutter/material.dart';
class Aftersigupadmin extends StatefulWidget {
  const Aftersigupadmin({super.key});

  @override
  State<Aftersigupadmin> createState() => _AftersigupadminState();
}

class _AftersigupadminState extends State<Aftersigupadmin> {
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
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                Image.asset('assest/mainlogo1.png'),
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
                                child: IconButton(onPressed: (){Navigator.pushNamed(context, '/supdate');}, icon: Icon(Icons.location_on_outlined,color: Colors.blue,size: 40,)),
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white70,

                                ),
                              ),
                              Text("Station Update",style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),),
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
