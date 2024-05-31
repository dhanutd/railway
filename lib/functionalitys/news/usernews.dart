import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
class Usernews extends StatefulWidget {
  const Usernews({super.key});

  @override
  State<Usernews> createState() => _UsernewsState();
}

class _UsernewsState extends State<Usernews> {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref("news");
  String? selectedVal = 'All';
  List<DropdownMenuItem> stationname=[];
  @override
  // void initState() {
  //   super.initState();
  //   getUniqueTypes();
  // }
  // Future<void> getUniqueTypes() async {
  //   try {
  //     final DataSnapshot dataSnapshot = await _databaseReference.child('users/$uid/yourField').once();
  //
  //     final List<dynamic> allValues = dataSnapshot.value ?? [];
  //     final Set<String> uniqueSet = Set<String>.from(allValues);
  //
  //
  //   } catch (error) {
  //     print("Error: $error");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double defaultHeight = screenHeight*0.8;
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
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 60, top: 20),
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
             Padding(
               padding: const EdgeInsets.only(left: 60,),
               child: StreamBuilder<QuerySnapshot>(
                   stream: FirebaseFirestore.instance.collection("news").snapshots(),
                   builder: (context,snapshot){
                     if(!snapshot.hasData){
                       Text("Loading");
                     }
                     else{

                      final names=snapshot.data!.docs.reversed.toList();
                      Set<String> uniqueTypes = Set<String>();
                      stationname.clear();
                      for (var name in names) {
                        // Check if the type is not already in the set
                        if (!uniqueTypes.contains(name['type'])) {
                          uniqueTypes.add(name['type']);
                          stationname.add(DropdownMenuItem(
                            value: name['type'],
                            child: Text(name['type']),
                          ));
                        }
                      }
                     }

                     return DropdownButton(
                       value: selectedVal,
                         items: stationname,
                         onChanged: (val){
                           setState(() {
                             selectedVal = val.toString();
                           });
                           print(selectedVal);
                     });
                       }
               ),
             ),
            Container(
              height: defaultHeight,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("news").snapshots(),
                  builder: (context,snapshot) {
                    if (!snapshot.hasData) {
                      Text("Loading....");
                    }
                    var items = snapshot.data?.docs.where((doc) => doc['type']==selectedVal).toList();
                    return ListView.builder(
                        itemCount: items?.length,
                        itemBuilder: (context,index){
                          var item=items?[index];
                          return Container(
                            child: ListTile(
                              title: Card(
                                   child: Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Column(
                                       children: [
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                             Text(item?['type'],style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18) ,),
                                             Text(item?['date'],style: TextStyle(fontWeight: FontWeight.bold),)
                                           ],
                                         ),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                           children: [
                                             Row(
                                               children: [
                                                 Text("Subject: ",style: TextStyle(fontWeight: FontWeight.bold),),
                                                 Text(item?['subject'],style: TextStyle(fontWeight: FontWeight.bold),)
                                               ],
                                             )
                                           ],
                                         ),
                                         SizedBox(height: 15,),
                                         Row(
                                           // mainAxisAlignment: MainAxisAlignment.start,
                                           children: [
                                             Flexible(child: Text("Description:  "+item?['description'],style: TextStyle(fontWeight: FontWeight.bold),softWrap: true,)),
                                           ],
                                         )
                                       ],
                                     ),
                                   ),
                              ),

                            ),
                          );
                        }
                    );
                  }

                  ),
            ),
          ],
        ),
      ),
    );
  }
}
