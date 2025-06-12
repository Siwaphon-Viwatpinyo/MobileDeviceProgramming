import 'package:flutter/material.dart';

import 'screen/home.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Teacher App'),
          backgroundColor: Colors.orangeAccent,
        ),
        body: const Home(),
      ),
    ),
  );
}
