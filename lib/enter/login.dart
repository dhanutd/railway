import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:railway/round_button.dart';
class Login_page extends StatefulWidget {
  const Login_page({super.key});

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  final _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formField=GlobalKey<FormState>();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[800],
          title: Text("Log in",

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

          // actions: [
          //   TextButton(onPressed: (){
          //     Navigator.pushNamed(context, '/reg');
          //   }, child:Text("Reg",
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontWeight: FontWeight.bold,
          //       fontSize: 25.0,
          //
          //     ),))
          // ],
        ),
        body: Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: _formField,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: const InputDecoration(
                            hintText: 'Email',

                            prefixIcon: Icon(Icons.email_rounded)
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            hintText: 'password',

                            prefixIcon: Icon(Icons.lock_open)
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter password';
                          }
                          return null;
                        },
                      ),
                    ],

                  ),

                ),
                SizedBox(height: 25,),
                Roundbutton(
    title: "LogIN",
    onTap: (){
    sigin(emailController.text, passwordController.text);
    },
    ),




                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("If you not exisiting user?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),),
                    TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/reg');
                      },
                      child: Text("SigUp"),
                    ),
                  ],

                )



              ],
            ))

    );
  }
  void route() async {
    User? user=FirebaseAuth.instance.currentUser;

    if(user != null) {
      String userid = user.uid;

      final DocumentReference collectionRef = _firestore
          .collection("users").doc(userid);


      DocumentSnapshot documentSnapshot = await collectionRef.get();
      bool dc=documentSnapshot.exists;
      print(dc);


      // print(collectionRef);
      if(documentSnapshot.exists){
        print(userid);
        print("hi");
        if (documentSnapshot.data() != null && documentSnapshot.data() is Map<String, dynamic>) {
          Map<String, dynamic> data = documentSnapshot.data() as Map<String,dynamic>;
          if (data.containsKey('role')) {
            String role = data['role'];
            if(role=="emp"){
              Navigator.pushNamed(context, '/aftersigemp');
            }
            else if(role=='admin'){
              Navigator.pushNamed(context, '/aftersigadmin');
            }
            else{
              Navigator.pushNamed(context, '/aftersigmanager');
            }
          }
          else{
            Navigator.pushNamed(context, '/aftersig');
          }
        }

      }

    }


    // DocumentSnapshot doc1 = await collectionRef.doc("emp").get();
  }

  //login function
  void sigin(String email,String password)async{
    if(_formField.currentState!.validate()){
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {
        Fluttertoast.showToast(msg: "login successful"),
      route(),
      }).catchError((e)
      {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
