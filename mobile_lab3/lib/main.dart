import 'package:flutter/material.dart';

//import 'screen/home.dart';
//import 'screen/addform.dart';
import 'screen/item.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('CET App ID:9999'),
          backgroundColor: Colors.orangeAccent,
          centerTitle: true,
        ),
        //body: const Home()
        body: const Item()
        
      ),
    );
  }
}