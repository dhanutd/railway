import 'package:flutter/material.dart';
import 'package:railway/SplashScreen.dart';
import 'package:railway/aftersiginmanager.dart';
import 'package:railway/aftersignup.dart';
import 'package:railway/components/profile.dart';
import 'package:railway/enter/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';

import 'package:railway/enter/login.dart';
import 'package:railway/enter/registr.dart';
import 'package:railway/functionalitys/Buggy/Navigation_buggy.dart';
import 'package:railway/functionalitys/Stationmanager/Station_information.dart';
import 'package:railway/functionalitys/Stationmanager/managernews.dart';
import 'package:railway/functionalitys/admin/aftersignadmin.dart';
import 'package:railway/functionalitys/booking/Entersd.dart';
import 'package:railway/functionalitys/booking/Passeneger.dart';
import 'package:railway/functionalitys/emp/Aftersignemp.dart';
import 'package:railway/functionalitys/emp/bugguemp/Navigationbuggemp.dart';
import 'package:railway/functionalitys/emp/luggageemp/Navigationluggageemp.dart';
import 'package:railway/functionalitys/luggage/Luggege_booking.dart';
import 'package:railway/functionalitys/luggage/Navigation_luggage.dart';
import 'package:railway/functionalitys/news/usernews.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
    options: const FirebaseOptions(apiKey: "AIzaSyDfvrmnHAFk2ecLpajOtErbaxqgkLXnhm8",
      appId: "1:944804125445:android:8ea807c564a2802c18b56c",
      messagingSenderId: "944804125445",
      projectId: "railway-50cbc",
      storageBucket: "railway-50cbc.appspot.com",
    ),
  )
      :await Firebase.initializeApp();
  runApp(const rou());
}
class rou extends StatelessWidget {
  const rou({super.key});

  @override
  Widget build(BuildContext context) {
    return (
        MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/splash',
          routes: {
            '/splash':(context)=>SplashScreen(),
            '/home':(context)=>Home(),
            '/login':(contex)=>Login_page(),
            '/reg':(context)=>Reg_page(),
            '/aftersig':(context)=>aftersigup(),
            '/profile':(context)=>Profile(),
            '/enterb':(context)=>Entersd(),

            '/aftersigemp':(context)=>Aftersiginemp(),
            '/aftersigadmin':(context)=>Aftersigupadmin(),
            '/luggageemp':(context)=>Navigationlemp(),
            '/buggyemp':(context)=>Navigationbuggyemp(),
            '/luggage':(context)=>Luggegebokking(),
            '/navil':(context)=>Navigationbarl(),
            '/navib':(context)=>Navigationbarb(),
            '/aftersigmanager':(context)=>Aftersiginmanager(),
            '/stationinfo':(context)=>Stationinformation(),
            '/stationnews':(context)=>Mangernews(),
            '/usernews':(context)=>Usernews(),



          },
        )
    );
  }
}
