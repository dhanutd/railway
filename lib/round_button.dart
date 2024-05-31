import 'package:flutter/material.dart';
class Roundbutton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const Roundbutton({super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child:Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.deepPurple[800],
            borderRadius: BorderRadius.circular(20)
        ),
        child: Center(child: Text(title,style: TextStyle(color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),),),
      ),
    );
  }
}
