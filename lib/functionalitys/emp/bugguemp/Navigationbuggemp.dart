
import 'package:flutter/material.dart';
import 'package:railway/functionalitys/emp/bugguemp/Statusbuggyemp.dart';
import 'package:railway/functionalitys/emp/bugguemp/Viewbuggy.dart';
class Navigationbuggyemp extends StatefulWidget {
  const Navigationbuggyemp({super.key});

  @override
  State<Navigationbuggyemp> createState() => _NavigationbuggyempState();
}

class _NavigationbuggyempState extends State<Navigationbuggyemp> {
  int myindex=0;
  List<Widget>widgetlist=const[
    Viewbuggy(),
    Statusbuggyemp()

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
          BottomNavigationBarItem(icon: Icon(Icons.view_agenda_outlined),label: "view Booking"),
          BottomNavigationBarItem(icon: Icon(Icons.confirmation_num_outlined),label: "Status")
        ],
      ),
    );
  }
}
