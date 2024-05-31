import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:railway/round_button.dart';
class Luggegebokking extends StatefulWidget {
  const Luggegebokking({super.key});

  @override
  State<Luggegebokking> createState() => _LuggegebokkingState();
}

class _LuggegebokkingState extends State<Luggegebokking> {
  final databaseRef=FirebaseDatabase.instance.ref("luaggege_booking");
  final TextEditingController namecontrolle=TextEditingController();
  final TextEditingController trainnamecontrolle=TextEditingController();
  final TextEditingController pnrcontrolle=TextEditingController();
  final TextEditingController classcontrolle=TextEditingController();
  final TextEditingController disticontrolle=TextEditingController();
  final TextEditingController nluaggegecontrolle=TextEditingController();
  final TextEditingController wluaggegecontrolle=TextEditingController();
  final TextEditingController phonecontrolle=TextEditingController();
  final _auth=FirebaseAuth.instance;
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: 600,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(

              children:<Widget> [
                Expanded(
                  child: Column(

                    children: [
                      Flexible(
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.only(left: 10, top: 20),
                              child: Text("Luggage Assistant \nBooking",
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
                                    controller: trainnamecontrolle,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'Enter train name';
                                      }},
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
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      Flexible(
                                        child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          validator: (value){
                                            if(value!.isEmpty){
                                              return 'Enter Weight.l';
                                            }},
                                          controller: wluaggegecontrolle,
                                          decoration: InputDecoration(
                                            hintText: "Total Weight",
                                          ),
                                        ),
                                      )
                                    ],
                                  ),

                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    maxLength: 10,
                                    controller: phonecontrolle,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'Enter phone';
                                      }},
                                    decoration: InputDecoration(
                                      hintText: "Phone Number",
                                    ),
                                  ),
                                  SizedBox(height: 15,),
                                  Roundbutton(title: "Booking", onTap: (){Add_data();}),


                                ],
                              ),
                              )
                            ),


                          ],

                        ),
                      ),

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
  void Add_data() async{
    if (_formField.currentState!.validate()) {
      try {
        final time=DateTime.now();
        final String formateddate=DateFormat('dd-MM-yyyy').format(time);
        User? user = _auth.currentUser;
        if(user!=null){
          String uid = user.uid;
          print(uid);
           databaseRef.child(DateTime.now().microsecondsSinceEpoch.toString()).set({
            'name':namecontrolle.text,
            'train_name':trainnamecontrolle.text,
            'ticket':pnrcontrolle.text,
            'seat':classcontrolle.text,
      
            'Phone':phonecontrolle.text,
            'status':"requested",
             'No_of_l':nluaggegecontrolle.text,
             't_W':wluaggegecontrolle.text,
             'uid':uid,
             'Date':formateddate.toString(),
          //
          });
      
          Fluttertoast.showToast(msg: "booking success");
        }
      }  catch (Error ) {
        print("error");
        Fluttertoast.showToast(msg: "Error occurred while booking");
      }
    }

  }
}
