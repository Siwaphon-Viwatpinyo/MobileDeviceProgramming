import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  const Item({super.key});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  int qty=0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$qty", style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          OutlinedButton(onPressed: () {
            setState(() {
              qty++;
            });
          }, child: const Text("+",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
          SizedBox(height: 20),
          OutlinedButton(onPressed: () {
            setState(() {
              qty=qty<=0? 0 : qty-1;
            });
          }, child: const Text("-",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
        ],
      ),
    );
  }
}