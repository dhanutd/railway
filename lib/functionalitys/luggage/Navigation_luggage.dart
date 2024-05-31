
import 'package:flutter/material.dart';
import 'package:railway/functionalitys/luggage/Luggege_booking.dart';
import 'package:railway/functionalitys/luggage/Statusl.dart';
class Navigationbarl extends StatefulWidget {
  const Navigationbarl({super.key});

  @override
  State<Navigationbarl> createState() => _NavigationbarlState();
}

class _NavigationbarlState extends State<Navigationbarl> {
  int myindex=0;
  List<Widget>widgetlist=const[
     Luggegebokking(),
    Statusl(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetlist[myindex],
      bottomNavigationBar: BottomNavigationBar(
       onTap: (index){
         setState(() {
           myindex=index;
         });
       },
        currentIndex: myindex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.book_online_outlined),label: "Booking"),
          BottomNavigationBarItem(icon: Icon(Icons.confirmation_num_outlined),label: "Status")
        ],
      ),
    );
  }
}
