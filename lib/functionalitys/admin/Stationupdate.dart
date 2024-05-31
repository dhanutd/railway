
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:railway/round_button.dart';
class Sattionupdate extends StatefulWidget {
  const Sattionupdate({super.key});

  @override
  State<Sattionupdate> createState() => _SattionupdateState();
}

class _SattionupdateState extends State<Sattionupdate> {
  final _formField=GlobalKey<FormState>();
  final TextEditingController stationname=TextEditingController();
  final TextEditingController stationid=TextEditingController();
  final TextEditingController ID=TextEditingController();
  final TextEditingController stationplatform=TextEditingController();
  final TextEditingController Noticketcounter=TextEditingController();
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
      body: SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
        child: Container(
          height: 500,
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
                              child: Text("Station Update",
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
                                        controller: stationname,
                                        decoration: InputDecoration(
                                          hintText: "Station Name",
                                        ),
                                      ),
                                      // SizedBox(height: 10,),

                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: stationid,
                                    decoration: InputDecoration(
                                      hintText: "Station code",
                                    ),
                                  ),
                                      Row(
                                        children: [
                                          Flexible(
                                            child: TextFormField(
                                              keyboardType: TextInputType.number,
                                              controller: stationplatform,
                                              decoration: InputDecoration(
                                                hintText: "No.platform",
                                              ),
                                            ),),
                                          SizedBox(width: 5,),
                                          Flexible(
                                            child: TextFormField(
                                              keyboardType: TextInputType.number,
                                              controller: Noticketcounter,
                                              decoration: InputDecoration(
                                                hintText: "No.ticket_counter",
                                              ),
                                            ),)
                                        ],
                                      ),

                                      SizedBox(height: 15,),
                                      Roundbutton(title: "Update", onTap: (){station_update();}),


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
  void station_update()async{
   final response=await http.post(
     Uri.parse("http://192.168.1.5:5000/Station_update"),
     headers: {"Content-Type": "application/json"},
     body: jsonEncode({
       "stationcode": stationid.text,
       "stationname": stationname.text,
       "noplatform": stationplatform.text,
       "noticketcounter": Noticketcounter.text,
     }),


   );
   if(response.statusCode==200){
     Fluttertoast.showToast(msg: "Updated successful");
   }else{
     Fluttertoast.showToast(msg: "Updated is failed. Status code ${response.statusCode}");
   }
  }
}
