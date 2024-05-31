import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../round_button.dart';
class Buggybooking extends StatefulWidget {
  const Buggybooking({super.key});

  @override
  State<Buggybooking> createState() => _BuggybookingState();
}

class _BuggybookingState extends State<Buggybooking> {
  final _auth=FirebaseAuth.instance;
  final databaseRef=FirebaseDatabase.instance.ref("buggy_booking");
  final TextEditingController namecontrolle=TextEditingController();
  final TextEditingController trainnamecontrolle=TextEditingController();
  final TextEditingController pnrcontrolle=TextEditingController();
  final TextEditingController classcontrolle=TextEditingController();
  final TextEditingController disticontrolle=TextEditingController();
  final TextEditingController nluaggegecontrolle=TextEditingController();
  final TextEditingController totalpcontrolle=TextEditingController();
  final TextEditingController phonecontrolle=TextEditingController();

  final _formField=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 10, top: 20),
                      child: Text("Buggy Service",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Form(
                          key: _formField,
                          child: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.text,
                                validator: (value){
                              if(value!.isEmpty){
                               return 'Enter name';
                                 }},
                                controller: namecontrolle,
                                decoration: InputDecoration(
                                  hintText: "Name",
                                ),
                              ),
                              // SizedBox(height: 10,),

                              TextFormField(
                                keyboardType: TextInputType.text,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Enter train name';
                                  }},
                                controller: trainnamecontrolle,
                                decoration: InputDecoration(
                                  hintText: "Train Name",
                                ),
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return 'Enter ticket number';
                                        }},
                                      controller: pnrcontrolle,
                                      decoration: InputDecoration(
                                        hintText: "Ticket Last 5 digit",
                                      ),
                                    ),),
                                  SizedBox(width: 5,),
                                  Flexible(
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return 'Enter class name';
                                        }},
                                      controller: classcontrolle,
                                      decoration: InputDecoration(
                                        hintText: "Class Name",
                                      ),
                                    ),)
                                ],
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return 'Enter No.l';
                                        }},
                                      controller: nluaggegecontrolle,
                                      decoration: InputDecoration(
                                        hintText: "Number of luggage",
                                      ),
                                    ),),
                                  SizedBox(width: 5,),
                                  Flexible(
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return 'Enter No.p';
                                        }},
                                      controller: totalpcontrolle,
                                      decoration: InputDecoration(
                                        hintText: "No.of Passanger",
                                      ),
                                    ),)
                                ],
                              ),

                              TextFormField(
                                keyboardType: TextInputType.text,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Enter phone';
                                  }},
                                maxLength: 10,
                                controller: phonecontrolle,
                                decoration: InputDecoration(
                                  hintText: "Phone Number",
                                ),
                              ),
                              SizedBox(height: 15,),
                             Roundbutton(title: "Booking", onTap: (){
                               Add_data();
                             }),


                            ],
                          ),
                        )
                    ),


                  ],

                ),

              ],
            ),
          ),

        ],
      ),

    );
  }
  void Add_data() async{
    if (_formField.currentState!.validate()) {
      try {
        final time=DateTime.now();
        final String formateddate=DateFormat('dd-MM-yyyy').format(time);
        User? user = _auth.currentUser;
        if(user!=null){
          String uid = user.uid;
      
          databaseRef.child(DateTime.now().microsecondsSinceEpoch.toString()).set({
            'name':namecontrolle.text,
            'train_name':trainnamecontrolle.text,
            'ticket':pnrcontrolle.text,
            'seat':classcontrolle.text,
      
            'Phone':phonecontrolle.text,
            'status':"requested",
            'No_of_l':nluaggegecontrolle.text,
            't_P':totalpcontrolle.text,
            'uid':uid,
            'Date':formateddate.toString(),
            //
          });
      
          Fluttertoast.showToast(msg: "booking success");
        }
      }  catch (Error ) {
      
        Fluttertoast.showToast(msg: "Error occurred while booking");
      }
    }

  }
}

