
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/shared/bloc_observer.dart';
import 'package:untitled/start.dart';
void main() {


  Bloc.observer = MyBlocObserver();
  runApp( MyApp());
}
class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)   {
    return MaterialApp(

      theme: ThemeData(primaryColor: Colors.blueGrey,
        // fontFamily: 'pac'
      ),
      debugShowCheckedModeBanner: false,
      home: StartAPP(),
    );
  }
}
