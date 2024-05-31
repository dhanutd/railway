import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Stationinformation extends StatefulWidget {
  const Stationinformation({super.key});

  @override
  State<Stationinformation> createState() => _StationinformationState();
}

class _StationinformationState extends State<Stationinformation> {
  final TextEditingController StationName= TextEditingController();
  final TextEditingController Contact= TextEditingController();
  final TextEditingController code= TextEditingController();
  final TextEditingController platform= TextEditingController();
  final TextEditingController ticketcounter= TextEditingController();


  bool _formSubmitted = false;
  void _loadFormState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _formSubmitted = prefs.getBool('formSubmitted') ?? false;
      if (_formSubmitted) {
        // Load stored data into text controllers
        StationName.text = prefs.getString('stationName') ?? '';
        Contact.text = prefs.getString('contact') ?? '';
        code.text = prefs.getString('stationCode') ?? '';
        platform.text = prefs.getString('platform') ?? '';
        ticketcounter.text = prefs.getString('ticketCounter') ?? '';
      }
    });
  }
  @override
  void initState() {
    super.initState();
    _loadFormState(); // Call _loadFormState to load data when the widget is initialized
  }

  void _saveFormState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('formSubmitted', _formSubmitted);
    if (_formSubmitted) {
      // Save data to SharedPreferences
      prefs.setString('stationName', StationName.text);
      prefs.setString('contact', Contact.text);
      prefs.setString('stationCode', code.text);
      prefs.setString('platform', platform.text);
      prefs.setString('ticketCounter', ticketcounter.text);
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
      // elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          )
      ),

    ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8,left: 20,right: 20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignmen,
          children: [

            Text("Station Information",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            TextField(
              controller: StationName,
              enabled: !_formSubmitted,
              decoration: InputDecoration(
                labelText: _formSubmitted ? 'Name' : 'Enter Station Name',
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: Contact,
                    enabled: !_formSubmitted,
                    decoration: InputDecoration(
                      labelText: _formSubmitted ? 'Phone Number' : 'Contact Number',
                    ),
                  ),),
                SizedBox(width: 5,),
                Flexible(
                  child: TextField(
                    controller: code,
                    enabled: !_formSubmitted,
                    decoration: InputDecoration(
                      labelText: _formSubmitted ? 'Station Code' : 'Station Code',
                    ),
                  ),)
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: platform,
                    enabled: !_formSubmitted,
                    decoration: InputDecoration(
                      labelText: _formSubmitted ? 'Platform' : 'No.of.platform',
                    ),
                  ),),
                SizedBox(width: 5,),
                Flexible(
                  child: TextField(
                    controller: ticketcounter,
                    enabled: !_formSubmitted,
                    decoration: InputDecoration(
                      labelText: _formSubmitted ? 'Ticket counter' : 'No.of.Ticket counter',
                    ),
                  ),)
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _formSubmitted
                  ? null
                  : () {
                Add_datai();
                // setState(() {
                //   _formSubmitted = true;
                //   // _saveFormState(); // Save the form state
                // });

              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
  void Add_datai()async{
    final FirebaseFirestore _firestore=FirebaseFirestore.instance;
    final _auth=FirebaseAuth.instance;
    User? user = _auth.currentUser;
    try {
      if (user != null) {
        String uid = user.uid;
        await _firestore.collection('Station_information').doc(uid).set({
              'name':StationName.text,
               'phone':Contact.text,
                'code':code.text,
               'platform':platform.text,
               'ticket_counter':ticketcounter.text,
        });
      }
      setState(() {
        _formSubmitted = true;
      });
      Fluttertoast.showToast(msg: "station information is stored");
    } catch (e) {
      Fluttertoast.showToast(msg: "station information is not stored");
    }
  }
}
