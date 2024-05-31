import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:railway/round_button.dart';
class Review_book extends StatefulWidget {
 final List<List<dynamic>> final_list;
 final List<dynamic> traindata;

  const Review_book({Key? key, required this.final_list,required this.traindata}) : super(key: key);

  @override
  State<Review_book> createState() => _Review_bookState();
}

class _Review_bookState extends State<Review_book> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
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
      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10,top: 8,bottom: 8),
        child: Container(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(left: 10,),
                child: Text("Review and Book",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("Train Name:  ${widget.traindata[1]} "
                        ,style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),),
                        Text("(${widget.traindata[0]})",style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),),

                      ],
                    ),
                    Text("${widget.traindata[2]}",style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),)
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("From: ${widget.traindata[8]}-${widget.traindata[4]}"),
                  Text("To: ${widget.traindata[8]}-${widget.traindata[5]}"),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("From: ${widget.traindata[6]}"),
                  Text("To: ${widget.traindata[7]}"),

                ],
              ),
              Padding(padding: EdgeInsets.only(left: 10,top: 20),
                child: Text("Passanger Details",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.final_list.length,
                  itemBuilder: (context, index) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.final_list[index].length,
                      itemBuilder: (context, subIndex) {
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${widget.final_list[index][subIndex][0]}"),
                              Text("Coach: ${widget.traindata[11]}-${widget.final_list[index][subIndex][4]+1}"),
                              Text("Age: ${widget.final_list[index][subIndex][2]} | ${widget.final_list[index][subIndex][3]}"),
                            ],
                          ),


                        );
                      },
                    );
                  },
                ),
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
           Roundbutton(title: "Pay and Book", onTap: (){
             print(widget.final_list);
             print(widget.traindata);
             Book_ticket();

           })

            ],
          ),
        ]
        ),
      )
    )
    );
  }
  Future <void> Book_ticket ()async{
    User? user=FirebaseAuth.instance.currentUser;
    String userid = user!.uid;
    print(widget.final_list[0][0][1]);
    final responce=await http.post(Uri.parse("http://192.168.1.6:5000/Booking_history"),
      headers: {"Content-Type": "application/json"},
      body:jsonEncode({
        "uid":userid.toString(),
        "ticketnumber":DateTime.now().microsecondsSinceEpoch.toString(),
        "phone":widget.final_list[0][0][1].toString(),
        "trainid":widget.traindata[0],
        "trainname":widget.traindata[1],
        "bookingdate":widget.traindata[8],
        "seattype":widget.traindata[11],
        "no_passanger":widget.traindata[12],
        "payment":"Success",
        "from_station":widget.traindata[6],
      "to_station":widget.traindata[7],
      "from_time":widget.traindata[4],
      "to_time":widget.traindata[5]
      }),

      );
    if(responce.statusCode==200){
      Fluttertoast.showToast(msg: "Booked successful");
    }else{
      Fluttertoast.showToast(msg: "Booked is failed. Status code ${responce.statusCode}");
    }


  }
}
