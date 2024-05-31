
import 'package:flutter/material.dart';
import 'package:railway/functionalitys/Buggy/Buggy_booking.dart';
import 'package:railway/functionalitys/Buggy/Statusb.dart';


class Navigationbarb extends StatefulWidget {
  const Navigationbarb({super.key});

  @override
  State<Navigationbarb> createState() => _NavigationbarbState();
}

class _NavigationbarbState extends State<Navigationbarb> {
  int myindex=0;
  List<Widget>widgetlist=const[
    Buggybooking(),
    Statusbuggy(),
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
