import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
class Statusluggageemp extends StatefulWidget {
  const Statusluggageemp({super.key});

  @override
  State<Statusluggageemp> createState() => _StatusluggageempState();
}

class _StatusluggageempState extends State<Statusluggageemp> {

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double defaultHeight = screenHeight*0.8;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[800],
        title: Text("RailWay +",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25.0,),
        ),
        // elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            )
        ),

      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
           height: defaultHeight,
          child: Column(
            children: [
              Expanded(child: FirebaseAnimatedList(
                  query: FirebaseDatabase.instance
                      .ref("luaggege_booking"),
                  itemBuilder: (context,snapshot,animation,index){
                    if(snapshot.value!=null){
                      if(snapshot.child('status').value.toString() != "requested") {
                        return ListTile(
                            title: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(

                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(snapshot
                                            .child('name')
                                            .value
                                            .toString()
                                            .toUpperCase(), style: TextStyle(
                                            fontWeight: FontWeight.bold),),
                                        Text("Date:"+snapshot
                                            .child('Date')
                                            .value
                                            .toString()
                                            .toUpperCase(), style: TextStyle(
                                            fontWeight: FontWeight.bold),),



                                      ],

                                    ),
                                    SizedBox(height: 8,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text("No.L:"),
                                            Text(snapshot
                                                .child('No_of_l')
                                                .value
                                                .toString(), style: TextStyle(
                                                fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("No.W:"),
                                            Text(snapshot
                                                .child('t_W')
                                                .value
                                                .toString(), style: TextStyle(
                                                fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text("T.Name:"),
                                            Text(snapshot
                                                .child("train_name")
                                                .value
                                                .toString(), style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("Seat.No:"),
                                            Text(snapshot
                                                .child("seat")
                                                .value
                                                .toString(), style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 8,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            Text("Ph.No:"),
                                            Text(snapshot
                                                .child("Phone")
                                                .value
                                                .toString(), style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text("Status:"),
                                            Text(snapshot
                                                .child("status")
                                                .value
                                                .toString(), style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                          ],
                                        ),

                                      ],
                                    )

                                  ],
                                ),
                              ),
                            )
                        );
                      }else{
                        return Container();
                      }

                    }
                    else{
                      return Text("Data no found");
                    }

                  }
              ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
