import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../round_button.dart';

class Mangernews extends StatefulWidget {
  const Mangernews({super.key});

  @override
  State<Mangernews> createState() => _MangernewsState();
}

class _MangernewsState extends State<Mangernews> {

  final _auth = FirebaseAuth.instance;

  String? selectedVal = 'All';
   List  stationlist=['All'];
  List<String> userIds =[] ;
  final TextEditingController subject=TextEditingController();
  final TextEditingController description=TextEditingController();
  final _formField=GlobalKey<FormState>();

   _Myformstate(){
     selectedVal=userIds[0];
   }

  @override
  Widget build(BuildContext context) {

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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, top: 20),
                child: Text(
                  "Station News Update",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              FutureBuilder<String>(
                future: getStation(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    userIds.clear();
                    userIds.add('All');
                    String? stname = snapshot.data;
                    userIds.add(stname!);


                    return DropdownButton(
                      value: selectedVal,
                      items: userIds.map((e) =>
                          DropdownMenuItem(child: Text(e), value: e,)).toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedVal = val.toString();
                        });
                      },
                    );
                  }
                },
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15),
                    child: Form(
                      key: _formField,
                        child: Column(
                      children: [
                        TextField(
                          controller: subject,

                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.blueAccent[50],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none,
                              ),
                            hintText: "Subject"
                          ),
                        ),
                        SizedBox(height: 25,),
                        TextField(
                          controller: description,
                           maxLines: 4,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.blueAccent[50],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Write the detail description"
                          ),
                        ),
                        SizedBox(height: 30,),
                        Roundbutton(title: "Update", onTap: (){
                          Add_date();
                        }),
                      ],
                    )),
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }

  Future<String>getStation() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference users = firestore.collection("Station_information");
    User? user = _auth.currentUser;
    String uid = user!.uid;
    DocumentSnapshot documentSnapshot = await users.doc(uid).get();
    String name = documentSnapshot['name'];
    return name;
  }
  void Add_date()async{
     final FirebaseFirestore firestore=FirebaseFirestore.instance;
    final time=DateTime.now();
    final String formateddate=DateFormat('dd-MM-yyyy').format(time);
    try {
      User? user = _auth.currentUser;
      if(user!=null){
        String uid = user.uid;
        print(uid);
        firestore.collection("news").doc(DateTime.now().microsecondsSinceEpoch.toString()).set({
          'type':selectedVal.toString(),
            'subject':subject.text,
            'description':description.text,
            'date':formateddate.toString(),
        });

        Fluttertoast.showToast(msg: "Updated success");
      }
    }  catch (Error ) {
      print("error");
      Fluttertoast.showToast(msg: "Error occurred while Updateing");
    }
  }
}
