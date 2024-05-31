import 'dart:convert';



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:railway/functionalitys/Booking/Passeneger.dart';
class Traindisplay extends StatefulWidget {
  final List<List<dynamic>> traindata;

  const Traindisplay({Key? key, required this.traindata}) : super(key: key);

  @override
  State<Traindisplay> createState() => _TraindisplayState();
}

class _TraindisplayState extends State<Traindisplay> {
  List<bool> _visibilityListB = List.generate(100, (index) => false);
  List<bool> _visibilityListC = List.generate(100, (index) => false);
  List<bool> _visibilityListD = List.generate(100, (index) => false);
  List<bool> _visibilityListE = List.generate(100, (index) => false);
 List<List<dynamic>> seatdata=[];
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
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.traindata.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${widget.traindata[index][0]} ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "(${widget.traindata[index][1]})",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Text("(${widget.traindata[index][2]})")
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${widget.traindata[index][4]}"),
                              Text("${widget.traindata[index][5]}")
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${widget.traindata[index][6]}"),
                              Text("${widget.traindata[index][7]}")
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                    int trainnumber=widget.traindata[index][0];
                                    int intermediat=widget.traindata[index][3];
                                    String coach="B";
                                    avalB(trainnumber,intermediat,coach);
                                  setState(() {
                                    _visibilityListC[index]=false;
                                    _visibilityListD[index]=false;
                                    _visibilityListE[index]=false;
                                    _visibilityListB[index]=!_visibilityListB[index];

                                  });
                                },
                                child: Text("2S-B"),
                              ),

                              ElevatedButton(
                                onPressed: () {
                                  int trainnumber=widget.traindata[index][0];
                                  int intermediat=widget.traindata[index][3];
                                  String coach="C";
                                  avalB(trainnumber,intermediat,coach);
                                  setState(() {
                                    _visibilityListC[index]=!_visibilityListC[index];
                                    _visibilityListD[index]=false;
                                    _visibilityListE[index]=false;
                                    _visibilityListB[index]=false;


                                  });
                                },
                                child: Text("2S-C"),
                              ),

                              ElevatedButton(
                                onPressed: () {
                                  int trainnumber=widget.traindata[index][0];
                                  int intermediat=widget.traindata[index][3];
                                  String coach="D";
                                  avalB(trainnumber,intermediat,coach);
                                  setState(() {
                                    _visibilityListC[index]=false;
                                    _visibilityListD[index]=!_visibilityListD[index];
                                    _visibilityListE[index]=false;
                                    _visibilityListB[index]=false;

                                  });
                                },
                                child: Text("SL-D"),
                              ),

                              ElevatedButton(
                                onPressed: () {
                                  int trainnumber=widget.traindata[index][0];
                                  int intermediat=widget.traindata[index][3];
                                  String coach="E";
                                  avalB(trainnumber,intermediat,coach);
                                  setState(() {
                                    _visibilityListC[index]=false;
                                    _visibilityListD[index]=false;
                                    _visibilityListE[index]=!_visibilityListE[index];
                                    _visibilityListB[index]=false;


                                  });
                                },
                                child: Text("AC-E"),
                              ),
                              IconButton(onPressed: (){
                               setState(() {
                                 _visibilityListC[index]=false;
                                 _visibilityListD[index]=false;
                                 _visibilityListE[index]=false;
                                 _visibilityListB[index]=false;
                               });

                              }, icon: Icon(Icons.close_rounded))
                            ],
                          ),
                          Visibility(
                              visible: _visibilityListB[index],
                              child: Avalibality(seatData: seatdata,traindata: widget.traindata[index],)
                          ),
                          Visibility(
                              visible: _visibilityListC[index],
                              child: Avalibality(seatData: seatdata,traindata: widget.traindata[index],)
                          ),
                          Visibility(
                              visible: _visibilityListD[index],
                              child: Avalibality(seatData: seatdata,traindata: widget.traindata[index],)
                          ),
                          Visibility(
                              visible: _visibilityListE[index],
                              child: Avalibality(seatData: seatdata,traindata: widget.traindata[index],)
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  Future<void> avalB(int trainnumber,int intermediate, String coach)async{
    final responce=await http.get(Uri.parse('http://192.168.1.6:5000//Prices_date?intermediate_station=${intermediate}&train_id=${trainnumber}&coach=${coach}'));
    if(responce.statusCode==200){
      setState(() {
        seatdata=List<List<dynamic>>.from(json.decode(responce.body));
      });

    print(seatdata);
    }else{
      throw Exception('Failed to load train data');
    }
  }
  Future<void> avalC(int trainnumber,int intermediate, String coach)async{
    final responce=await http.get(Uri.parse('http://192.168.1.6:5000//Prices_date?intermediate_station=${intermediate}&train_id=${trainnumber}&coach=${coach}'));
    if(responce.statusCode==200){
      setState(() {
        seatdata=List<List<dynamic>>.from(json.decode(responce.body));
      });

      print(seatdata);
    }else{
      throw Exception('Failed to load train data');
    }
  }
  Future<void> avalD(int trainnumber,int intermediate, String coach)async{
    final responce=await http.get(Uri.parse('http://192.168.1.6:5000//Prices_date?intermediate_station=${intermediate}&train_id=${trainnumber}&coach=${coach}'));
    if(responce.statusCode==200){
      setState(() {
        seatdata=List<List<dynamic>>.from(json.decode(responce.body));
      });

      print(seatdata);
    }else{
      throw Exception('Failed to load train data');
    }
  }
  Future<void> avalE(int trainnumber,int intermediate, String coach)async{
    final responce=await http.get(Uri.parse('http://192.168.1.6:5000//Prices_date?intermediate_station=${intermediate}&train_id=${trainnumber}&coach=${coach}'));
    if(responce.statusCode==200){
      setState(() {
        seatdata=List<List<dynamic>>.from(json.decode(responce.body));
      });

      print(seatdata);
    }else{
      throw Exception('Failed to load train data');
    }
  }
}
class Avalibality extends StatefulWidget {
  final List<List<dynamic>> seatData;
  final List<dynamic> traindata;

  const Avalibality({Key? key, required this.seatData,required this.traindata}) : super(key: key);

  @override
  State<Avalibality> createState() => _AvalibalityState();
}

class _AvalibalityState extends State<Avalibality> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: (){
                  setState(() {
                    widget.traindata.add(widget.seatData[0][0]);
                    widget.traindata.add(widget.seatData[0][1]);
                    widget.traindata.add(widget.seatData[0][2]);
                    widget.traindata.add(widget.seatData[0][3]);
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Passengerdetail(traindata:widget.traindata)));
              },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("${widget.seatData[0][0]}")
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${widget.seatData[0][1]}"),
                              Text("Rs-${widget.seatData[0][2]}")
                            ],
                          ),
                        ],
                      )
                    ),
                    height: 60,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white70,
                    ),
                  ),
              ),
              TextButton(
                onPressed: (){
                  setState(() {
                    widget.traindata.add(widget.seatData[1][0]);
                    widget.traindata.add(widget.seatData[1][1]);
                    widget.traindata.add(widget.seatData[1][2]);
                    widget.traindata.add(widget.seatData[1][3]);
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Passengerdetail(traindata:widget.traindata)));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("${widget.seatData[1][0]}")
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${widget.seatData[1][1]}"),
                              Text("Rs-${widget.seatData[1][2]}")
                            ],
                          ),
                        ],
                      )
                  ),
                  height: 60,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white70,
                  ),
                ),
              ),
              TextButton(
                onPressed: (){
                  setState(() {
                    widget.traindata.add(widget.seatData[2][0]);
                    widget.traindata.add(widget.seatData[2][1]);
                    widget.traindata.add(widget.seatData[2][2]);
                    widget.traindata.add(widget.seatData[2][3]);
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Passengerdetail(traindata:widget.traindata)));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("${widget.seatData[2][0]}")
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${widget.seatData[2][1]}"),
                              Text("Rs-${widget.seatData[2][2]}")
                            ],
                          ),
                        ],
                      )
                  ),
                  height: 60,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white70,
                  ),
                ),
              ),
              TextButton(
                onPressed: (){
                  setState(() {
                    widget.traindata.add(widget.seatData[3][0]);
                    widget.traindata.add(widget.seatData[3][1]);
                    widget.traindata.add(widget.seatData[3][2]);
                    widget.traindata.add(widget.seatData[3][3]);
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Passengerdetail(traindata:widget.traindata)));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("${widget.seatData[3][0]}")
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${widget.seatData[3][1]}"),
                              Text("Rs-${widget.seatData[3][2]}")
                            ],
                          ),
                        ],
                      )
                  ),
                  height: 60,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

