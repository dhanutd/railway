import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:railway/model/User_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:railway/round_button.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Reg_page extends StatefulWidget {
  const Reg_page({super.key});

  @override
  State<Reg_page> createState() => _Reg_pageState();
}

class _Reg_pageState extends State<Reg_page> {
  final _auth=FirebaseAuth.instance;
  final _formField=GlobalKey<FormState>();
  final emailController=TextEditingController();
  final fnameController=TextEditingController();
  final lnameController=TextEditingController();
  final passwordController=TextEditingController();
  final cofpasswordController=TextEditingController();
  // FirebaseAuth _auth =FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[800],
          title: Text("Reg",
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
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Form(
                    key: _formField,
                    child: Column(
                      children: [

                        TextFormField(
                          controller: fnameController,

                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              hintText: "First name",
                              filled: true,
                              fillColor: Colors.blueAccent[50],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
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
                          controller: lnameController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              hintText: "last name",
                              filled: true,
                              fillColor: Colors.blueAccent[50],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide.none,
                              )
                          ),
                          validator: (value){
                            RegExp regexp1=new RegExp(r'^[a-z,A-z]{3,}$');
                            if(value!.isEmpty){
                              return 'Last name cannot be empty';
                            }
                            if(!regexp1.hasMatch(value)){
                              return "Enter valid name(Min. 3character)";
                            }
                          },
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email_rounded),
                              hintText: "email",
                              filled: true,
                              fillColor: Colors.blueAccent[50],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide.none,
                              )
                          ),
                          validator: (value){
                            // RegExp gmailRegex = RegExp(r'^[a-z,A-Z,0-9]@gmail.com$');
                            if(value!.isEmpty){
                              return 'email cannot be empty';
                            }
                            // if(!gmailRegex.hasMatch(value)){
                            //   return "Enter valid gmail";
                            // }
                          },
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              hintText: "Password",
                              filled: true,
                              fillColor: Colors.blueAccent[50],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide.none,
                              )
                          ),

                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: cofpasswordController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            hintText: "Confirn password",
                            filled: true,
                            fillColor: Colors.blueAccent[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Enter password';
                            }

                            if(passwordController.text!=cofpasswordController.text){
                              return "Password is not matching";
                            }
                            return null;
                          },
                        ),
                      ],

                    ),

                  ),

                  SizedBox(height: 25,),
                  Roundbutton(
                    title: "Create Account",
                    onTap: (){
                      sigUp(emailController.text, passwordController.text);
                    },
                  ),
                  SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already you have account?"),
                      TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text("Log In"),
                      ),
                    ],

                  )
                ],
              )),
        )

    );
  }
  void sigUp(String email,String password)async{
    if(_formField.currentState!.validate()){
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
        postDetailtofirebase()
      }).catchError((e)
      {
        Fluttertoast.showToast(msg: e!.message);
      });

    }
  }
  postDetailtofirebase()async{
    //calling firestore
    //calling our user model
    //sending these value
    FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
    User? user =_auth.currentUser;
    UserModel userModel=UserModel();
    //writing data
    userModel.email=user!.email;
    userModel.uid=user.uid;
    userModel.firstname=fnameController.text;
    userModel.lastname=lnameController.text;
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully");
    Navigator.pushNamed(context, '/aftersig');
  }
}
