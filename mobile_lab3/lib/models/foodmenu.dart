import 'package:flutter/material.dart';

enum Foodpic {
  menu1(namefood: "สุกี้", image: "assets/images/1.png", backgroundColor: Colors.amberAccent),
  menu2(namefood: "สลัดรวม", image: "assets/images/2.png", backgroundColor: Colors.greenAccent),
  menu3(namefood: "สเต็กหมู", image: "assets/images/3.png", backgroundColor: Colors.blueAccent),
  menu4(namefood: "สเต็กเนื้อ", image: "assets/images/4.png", backgroundColor: Colors.redAccent),
  menu5(namefood: "แฮมเบอร์เกอร์", image: "assets/images/5.png", backgroundColor: Colors.purpleAccent),
  menu6(namefood: "พิซ่า", image: "assets/images/6.png", backgroundColor: Colors.orangeAccent),
  menu7(namefood: "ก๋วยเตี๋ยว", image: "assets/images/7.png", backgroundColor: Colors.blueGrey);
  final String namefood;
  final String image;
  final Color backgroundColor;
  const Foodpic({required this.image, required this.namefood, required this.backgroundColor });
}

enum FoodType {
  ttype1(name: "Fast Food"),
  ttype2(name: "Italian"),
  ttype3(name: "Healthy"),
  ttype4(name: "Japanese");
  final String name;
  const FoodType({required this.name});
}

class Foodmenu {
  Foodmenu({
    required this.name,
    required this.type,
    required this.component,
    required this.price,
    required this.foodpic, required Color backgroundColor,
  });
  String name;
  String type;
  String component;
  int price;
  Foodpic foodpic;
}

List<Foodmenu> emp = [
  Foodmenu(
    name: 'Burger',
    type: 'Fast Food',
    component: 'Bread, Meat, Cheese',
    price: 50,
    foodpic: Foodpic.menu1,
    backgroundColor: Foodpic.menu1.backgroundColor, // Added background color
  ),

];
