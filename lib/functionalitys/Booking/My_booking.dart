import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Mybooking extends StatefulWidget {
  const Mybooking({super.key});

  @override
  State<Mybooking> createState() => _MybookingState();
}

class _MybookingState extends State<Mybooking> {
  List <List <dynamic>> Booking_data=[];
  @override
  void initState(){
    super.initState();
    featch_data();
  }
  Future <void> featch_data()async{
    User? user=FirebaseAuth.instance.currentUser;
    String userid = user!.uid;
    final response= await http.get(Uri.parse('http://192.168.1.6:5000/My_booking?user_id=${userid}'));

    if(response.statusCode==200){
      setState(() {
        Booking_data=List<List<dynamic>>.from(json.decode(response.body));
      });
     }else{
  throw Exception('Failed to load train data');
  }
    print(Booking_data);
    
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double defaultHeight = screenHeight * 0.2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[800],
        title: Text(
          "RailWay +",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 500, // Specify a fixed height or use constraints
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "My Booking",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      featch_data();
                    },
                    child: Text("My Booking"),
                  )
                ],
              ),
              SizedBox(
                height: defaultHeight , // Adjust as needed
                child:ListView.builder(
                  itemCount: Booking_data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Padding(
                        padding: EdgeInsets.only(  top: 8, bottom: 8),
                        child: Container(
                          child: Card(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Train Name:  ${Booking_data[index][5]} ",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "(${Booking_data[index][4]})",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("From: ${Booking_data[index][7]}-${Booking_data[index][12]}"),
                                    Text("To: ${Booking_data[index][7]}-${Booking_data[index][13]}"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("From: ${Booking_data[index][10]}"),
                                    Text("To: ${Booking_data[index][11]}"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Ticket.No: ${Booking_data[index][2]}")
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Coach: ${Booking_data[index][7]}"),
                                    Text("Status:${Booking_data[index][9]}")
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Phone: ${Booking_data[index][3]}"),
                                    Text("No.Passanger:${Booking_data[index][8]}")
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
