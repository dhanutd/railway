import 'dart:typed_data';

import 'package:railway/components/Util.dart';
import 'package:railway/round_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:railway/model/Add_data.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formField=GlobalKey<FormState>();
  final TextEditingController fnamecontroll= TextEditingController();
  final TextEditingController lnamecontroll= TextEditingController();
  final TextEditingController phonecontroll= TextEditingController();
  final TextEditingController addharcontroll= TextEditingController();
  final TextEditingController addresscontroll= TextEditingController();
  Uint8List? _image;
  @override
  void initState() {
    super.initState();
    // Initialize your controllers here
    fnamecontroll.text = '';  // Optionally set initial values if needed
    lnamecontroll.text = '';
    phonecontroll.text = '';
    addharcontroll.text = '';
    addresscontroll.text = '';
  }
  void saveprofile() async{
    if(_formField.currentState!.validate()) {
      String fname = fnamecontroll.text;
      String lname = lnamecontroll.text;
      String phone = phonecontroll.text;
      String addhar = addharcontroll.text;
      String address = addresscontroll.text;
      if (_image != null) {

        // file: _image!);
      }
     final String resp = await Sotredata().saveData(fname: fname,
          lname: lname,
          phone: phone,
          addhar: addhar,
          address: address,
          file: _image!);


    }
  }


  void selectImage() async{
    Uint8List img=await pickimage(ImageSource.gallery);
    setState(() {
      _image=img;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[800],
          title: Text("Profile",
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
          physics: BouncingScrollPhysics(),
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        _image !=null?
                        CircleAvatar(
                          radius: 90.0,
                          backgroundImage: MemoryImage(_image!),
                        ):
                        CircleAvatar(
                          backgroundImage: AssetImage('assest/default.jpg'),
                          radius: 90.0,
                        ),
                        Positioned(
                          bottom: 30,
                          right: 30,
                          child: IconButton(onPressed: selectImage,
                            icon: Icon(Icons.camera_alt,
                              color: Colors.black,

                            ),
                          ),
                        ),
                      ],
                    ),
                    Form(
                      key:_formField,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: fnamecontroll,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                hintText: "First name",
                                filled: true,
                                fillColor: Colors.blueAccent[50],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                )
                            ),

                            validator: (value){
                              RegExp regexp=new RegExp(r'^[a-z,A-z]{3,}$');
                              if(value!.isEmpty){
                                return 'First name cannot be empty';
                              }
                              if(!regexp.hasMatch(value)){
                                return "Enter valid name(Min. 3character)";
                              }

                            },

                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: lnamecontroll,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                hintText: "Last name",
                                filled: true,
                                fillColor: Colors.blueAccent[50],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                )
                            ),

                            validator: (value){
                              RegExp regexp=new RegExp(r'^[a-z,A-z]{1,}$');
                              if(value!.isEmpty){
                                return 'Last name cannot be empty';
                              }
                              if(!regexp.hasMatch(value)){
                                return "Enter valid name(Min. 1character)";
                              }

                            },

                          ),

                          SizedBox(height: 10,),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: phonecontroll,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                hintText: "Phone Number",
                                filled: true,
                                fillColor: Colors.blueAccent[50],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                )
                            ),

                            validator: (value){
                              RegExp regexp=new RegExp(r'^[0-9]{10}$');
                              if(value!.isEmpty){
                                return ' Phone Number cannot be empty';
                              }
                              if(!regexp.hasMatch(value)){
                                return "Enter valid Phone number";
                              }

                            },

                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: addharcontroll,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                hintText: "Addhar Number",
                                filled: true,
                                fillColor: Colors.blueAccent[50],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                )
                            ),

                            validator: (value){
                              RegExp regexp=new RegExp(r'^[0-9]{10}$');
                              if(value!.isEmpty){
                                return 'Addhar number cannot be empty';
                              }
                              if(!regexp.hasMatch(value)){
                                return "Enter valid Addhar number";
                              }

                            },

                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            maxLines: 4,
                            keyboardType: TextInputType.text,
                            controller: addresscontroll,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.location_city_outlined),
                                hintText: "Address",
                                filled: true,
                                fillColor: Colors.blueAccent[50],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                )
                            ),

                            validator: (value){
                              // RegExp regexp=new RegExp(r'^[0-9]{10}$');
                              if(value!.isEmpty){
                                return 'address cannot be empty';
                              }


                            },

                          ),
                          SizedBox(height: 10,),
                          Roundbutton(title: "Update Profile", onTap:(){
                            saveprofile();

                          }),


                        ],
                      ),
                    )

                  ],
                ),
              )
          ),
        )

    );
  }
}
