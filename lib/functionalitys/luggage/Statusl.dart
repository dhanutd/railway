

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Statusl extends StatefulWidget {
  const Statusl({super.key});

  @override
  State<Statusl> createState() => _StatuslState();
}

class _StatuslState extends State<Statusl> {
  final _auth=FirebaseAuth.instance;






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
        child: Container(
          height: defaultHeight,
          child: Column(
            children: [
                Expanded(child: FirebaseAnimatedList(
                    query: FirebaseDatabase.instance
                        .ref("luaggege_booking"),
                    itemBuilder: (context,snapshot,animation,index){
                      User? user=_auth.currentUser;
                      String uid=user!.uid;
                      print(uid);
                      if(snapshot.value!=null){
                        if(snapshot.child('uid').value.toString() == uid) {
                          print("condition ok");
                          String status=snapshot
                              .child("status")
                              .value
                              .toString();
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
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                              Text(status,style: TextStyle(
                                                  fontWeight: FontWeight.bold)),

                                            ],
                                          ),
                                          ElevatedButton(
                                            onPressed: status !="Approved"
                                                ? null
                                                : () {
                                              updateStatus(snapshot.key);
                                              print('Button Pressed');
                                            },
                                            child: Text("Completed"),
                                          ),

                                        ],
                                      ),
                                      SizedBox(height: 3,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text("Staff name:"),
                                              Text(snapshot
                                                  .child("empfname")
                                                  .value
                                                  .toString(), style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                              Text(" "+snapshot
                                                  .child("emplname")
                                                  .value
                                                  .toString(), style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Staff phone:"),
                                              Text(snapshot
                                                  .child("empphone")
                                                  .value
                                                  .toString(), style: TextStyle(
                                                  fontWeight: FontWeight.bold)),

                                            ],
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [

                                          IconButton(onPressed: status!="Completed" ? null: () {delete(snapshot.key);},
                                              icon: Icon(Icons.delete_outline))
                                        ],
                                      ),


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
  void updateStatus(String? dataKey) {
    try{
      if (dataKey != null) {
        print(dataKey);

        FirebaseDatabase.instance
            .ref("luaggege_booking").child(dataKey).update({
          'status': "Completed",
        });
        Fluttertoast.showToast(msg: "sucessfuly updated");
      }else{
        print("data key not found");
      }
    }catch(error){
      Fluttertoast.showToast(msg: "erro was occuring");
    }

  }
  void delete(String ? datakey){
    try{
      if(datakey!=null){
        FirebaseDatabase.instance
            .ref("luaggege_booking").child(datakey).remove();
        Fluttertoast.showToast(msg: "sucessfuly deleted");
      }

    }catch(error){
      Fluttertoast.showToast(msg: "error was occuring");
    }
  }

}




