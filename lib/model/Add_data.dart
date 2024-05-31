import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
final FirebaseStorage _storage=FirebaseStorage.instance;
final FirebaseFirestore _firestore=FirebaseFirestore.instance;
final _auth=FirebaseAuth.instance;
class Sotredata{
  Future<String> uploadImageToStorage(String childName,Uint8List file) async{
    Reference ref= _storage.ref().child(childName);
    UploadTask uploadTask=ref.putData(file);
    TaskSnapshot snapshot=await uploadTask;
    String downloadurl=await snapshot.ref.getDownloadURL();
    return downloadurl;
  }

  Future<String> saveData({
    required String fname,
    required String lname,
    required String phone,
    required String addhar,
    required String address,
    required Uint8List file
  }) async {
    String resp = 'Some Error occurred ';

    try {
      User? user = _auth.currentUser;

      if (user != null) {
        String uid = user.uid;

        String imageurl = await uploadImageToStorage(uid, file);


        await _firestore.collection('user_profile').doc(uid).set({
          'fname': fname,
          'lname': lname,
          'phone': phone,
          'addhar': addhar,
          'address': address,
          'uid': uid,
          'imagelink': imageurl
        });
        Fluttertoast.showToast(msg: "Account created successfully");

        resp = 'Successfully updated';
      } else {
        resp = 'User is null';
      }
    } catch (err) {
      resp = err.toString();
    }

    return resp;
  }


}