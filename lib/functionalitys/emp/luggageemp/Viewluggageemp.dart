import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Viewluggage extends StatefulWidget {
  const Viewluggage({super.key});

  @override
  State<Viewluggage> createState() => _ViewluggageState();
}

class _ViewluggageState extends State<Viewluggage> {
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final  databaseReference =
  FirebaseDatabase.instance.ref('"luaggege_booking"');

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double defaultHeight = screenHeight*0.8;
    return Scaffold(
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
          width: double.infinity,
          child: Column(
            children: [
              Expanded(child: FirebaseAnimatedList(
                  query: FirebaseDatabase.instance
                      .ref("luaggege_booking"),
                  itemBuilder: (context,snapshot,animation,index){
                    if(snapshot.value!=null){
                      if(snapshot.child('status').value.toString() == "requested") {

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
                                                .child("Seat")
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
                                        ElevatedButton(
                                          onPressed: () {
                                            // When the user taps the ElevatedButton, update the status
                                            updateStatus(snapshot.key);

                                          },
                                          child: Text("Approve"),
                                        )
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
  void updateStatus(String? dataKey)async {
    try{
      if (dataKey != null) {
        User? user=_auth.currentUser;
        String? uid=user?.uid;
        DocumentSnapshot userSnapshot =
            await FirebaseFirestore.instance.collection('user_profile').doc(uid).get();
        if(userSnapshot.exists){
          String fname=userSnapshot['fname'];
          String lname=userSnapshot['lname'];
          String phone=userSnapshot['phone'];
          FirebaseDatabase.instance
              .ref("luaggege_booking").child(dataKey).update({
            'status': "Approved",
            'empfname':fname.toString(),
            'emplname':lname.toString(),
            'empphone':phone.toString(),
          });
          Fluttertoast.showToast(msg: "sucessfuly updated");
        }


        FirebaseDatabase.instance
            .ref("luaggege_booking").child(dataKey).update({
          'status': "Approved",
        });
        Fluttertoast.showToast(msg: "sucessfuly updated");
      }else{
        print("data key not found");
      }
    }catch(error){
      Fluttertoast.showToast(msg: "erro was occuring");
    }
   
  }
}
