
import 'dart:async';
import 'package:flutter/material.dart';

import 'layout/HomeLayout.dart';
class StartAPP extends StatefulWidget {
  @override
  _StartAPPState createState() => _StartAPPState();
}
class _StartAPPState extends State<StartAPP> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(
        seconds: 4
    ), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeLyout()));
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Container(
            child:Column(
              children: [
                SizedBox(
                  height: 250,
                )
                ,CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 110,
                  backgroundImage: AssetImage('assets/image/25.jpg'),
                ),
                SizedBox(

                  height: 10,
                ),
                Text('ToDo',style:TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold
                ),)
              ],
            ),

        ),
      ),
    );
  }
}
