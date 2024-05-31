
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:railway/round_button.dart';
import 'Traindisplay.dart';
class Entersd extends StatefulWidget {
  const Entersd({super.key});

  @override
  State<Entersd> createState() => _EntersdState();
}

class _EntersdState extends State<Entersd> {
  final TextEditingController fromcontroll = TextEditingController();
  final TextEditingController destcontroll = TextEditingController();
  final _formField = GlobalKey<FormState>();
  List <List <dynamic>> traindata=[];
  @override
  void initState(){
    super.initState();
    featchdata();
  }
  Future<void> featchdata()async{
    final responce=await http.get(Uri.parse('http://192.168.1.6:5000/Search_book?from_station=${fromcontroll.text}&to_station=${destcontroll.text}'));
    if(responce.statusCode==200){
      setState(() {
        traindata=List<List<dynamic>>.from(json.decode(responce.body));
      });
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Traindisplay(traindata: traindata)));

    }else{
      throw Exception('Failed to load train data');
    }
  }
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
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )
          ),

        ),
        body: Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(left: 10, top: 20),
                    child: Text("Train Search",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,

                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(20),
                    child: Form(
                      key: _formField,
                      child: Container(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: fromcontroll,
                               keyboardType: TextInputType.number,
                              decoration: InputDecoration(

                                  hintText: "From station",
                                  filled: true,
                                  fillColor: Colors.blueAccent[50],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide: BorderSide.none,
                                  )
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 30),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: destcontroll,

                                  decoration: InputDecoration(

                                      hintText: "Destination station",
                                      filled: true,
                                      fillColor: Colors.blueAccent[50],
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        borderSide: BorderSide.none,
                                      )
                                  ),
                                )
                            ),
                            Padding(padding: EdgeInsets.only(top: 30),
                              child: Roundbutton(title: "Search", onTap: () {
                                featchdata();
                              }),),


                          ],

                        ),
                      ),
                    ),
                  )


                ]
            ),
          ),
        )
    );
  }


}
