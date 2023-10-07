import 'package:calculadoraimcflutter/pages/mainpPage.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
    home: const MainPage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.purple,));
  }

}
