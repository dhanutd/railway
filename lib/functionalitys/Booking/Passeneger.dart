// import 'package:fireflutterfloder/round_button.dart';

import 'package:flutter/material.dart';
import 'package:railway/functionalitys/Booking/Review.dart';


import 'Addpassenger.dart';
class Passengerdetail extends StatefulWidget {
  final List<dynamic> traindata;

  const Passengerdetail({Key? key, required this.traindata}) : super(key: key);
  @override
  State<Passengerdetail> createState() => _PassengerdetailState();
}
List<String> genderoption=['Male','Female'];
class _PassengerdetailState extends State<Passengerdetail> {
  List<Addpassenger> passengerlist=List.empty(growable: true);
   List<List<dynamic>> final_list=[];
  final TextEditingController namecontroll=TextEditingController();
  final TextEditingController citycontroll=TextEditingController();
  final TextEditingController pincontroll=TextEditingController();
  final _formField=GlobalKey<FormState>();
  String currentgender=genderoption[0];

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
      body:SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
            children: [
              Padding(padding: EdgeInsets.only(left: 10,top: 20),
                child:Text("Passenger Details",
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
                          keyboardType: TextInputType.text,
                          controller: namecontroll,
                          decoration: InputDecoration(
                            hintText: "Name",
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 5),
                            child:TextFormField(
                              keyboardType: TextInputType.number,
                              controller: citycontroll,
                              maxLength: 10,
                              decoration: InputDecoration(
                                hintText: "Phone",
                              ),
                            )
                        ),
                        Padding(padding: EdgeInsets.only(top: 5),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: pincontroll,
                            decoration: InputDecoration(
                              hintText: "Age",

                            ),
                          ),

                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget> [
                            Flexible(child: ListTile(
                              title: const Text("Male",style: TextStyle(color: Colors.black),),
                              leading: Radio(
                                value: genderoption[0],
                                groupValue: currentgender,
                                onChanged: (value){
                                  setState(() {
                                    currentgender=value.toString();
                                  });
                                },

                              ),
                            ),),
                            Flexible(child: ListTile(
                              title: const Text("FeMale",style: TextStyle(color: Colors.black),),
                              leading: Radio(
                                value: genderoption[1],
                                groupValue: currentgender,
                                onChanged: (value){
                                  setState(() {
                                    currentgender=value.toString();
                                  });
                                },

                              ),
                            ),)
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 30),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(onPressed: (){
                                String name=namecontroll.text;
                                String city=citycontroll.text;
                                String pincode=pincontroll.text;
                                String updategender=currentgender;

                                if(name.isNotEmpty && city.isNotEmpty && pincode.isNotEmpty && updategender.isNotEmpty){
                                  setState(() {
                                    namecontroll.text='';
                                    citycontroll.text='';
                                    pincontroll.text='';
                                    passengerlist.add(Addpassenger(name, city, pincode, updategender));
                                  });

                                }

                              },
                                  // style:ButtonStyle(backgroundColor: Colors.deepPurple[800],),
                                  child: Text("ADD")),
                              ElevatedButton(onPressed: (){
                                print(widget.traindata);
                                int count =widget.traindata[9];
                                setState(() {
                                    widget.traindata.add(passengerlist.length);
                                  final_list.add(passengerlist.map((passenger) => [
                                    // if( count!=widget.traindata[9]){
                                    //
                                    //   count=count-1
                                    //   },

                                      passenger.name,
                                      passenger.city,
                                      passenger.pincode,
                                      passenger.gender,
                                   count= count-1,


                                  ]).toList());

                                });

                                print(final_list);
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Review_book(final_list: final_list,traindata: widget.traindata,)));
                              }, child: Text("Confirm"))
                            ],
                          )
                        ),
                        passengerlist.isEmpty ? Text("No Passenger added",
                            style: TextStyle(color: Colors.black,fontSize: 20)):
                        Container(
                          height: 500,
                          child: Expanded(
                            child: ListView.builder(
                              itemCount: passengerlist.length,
                              itemBuilder: (context,index)=>getRow(index),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),


            ]
        ),
      ),
    );
  }
  Widget getRow(int index){
    return ListTile(
      title: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Text(passengerlist[index].name,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                Text(passengerlist[index].gender,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),


              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(passengerlist[index].city,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                  Text(passengerlist[index].pincode,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)

                ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                IconButton(onPressed: (){
                  setState(() {
                    passengerlist.removeAt(index);
                  });
                }, icon: Icon(Icons.delete)),

              ],
            )
          ],
        ),
      ),
    );
  }
}
