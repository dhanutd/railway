
import 'package:flutter/material.dart';
import 'package:railway/functionalitys/emp/luggageemp/Statusluggageemp.dart';
import 'package:railway/functionalitys/emp/luggageemp/Viewluggageemp.dart';
class Navigationlemp extends StatefulWidget {
  const Navigationlemp({super.key});

  @override
  State<Navigationlemp> createState() => _NavigationlempState();
}

class _NavigationlempState extends State<Navigationlemp> {
  int myindex=0;
  List<Widget>widgetlist=const[
      Viewluggage(),
       Statusluggageemp(),

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
