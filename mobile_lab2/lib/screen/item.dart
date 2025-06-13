import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  const Item({super.key});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
List emp = ["พนักงาน1", "พนักงาน2", "พนักงาน3", "พนักงาน4", "พนักงาน5"];


  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: emp.length, itemBuilder: (context, index){
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.amberAccent,          
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 2,
          vertical: 3,
        ),
        padding: const EdgeInsets.all(30),
        child: Text(
          emp[index],
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      );
    });
  
  }
}
