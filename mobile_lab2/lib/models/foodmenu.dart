import 'package:flutter/material.dart';

enum Foodpic {
  menu1(image: "assets/images/1.png", backgroundColor: Colors.amberAccent),
  menu2(image: "assets/images/2.png", backgroundColor: Colors.greenAccent),
  menu3(image: "assets/images/3.png", backgroundColor: Colors.blueAccent),
  menu4(image: "assets/images/4.png", backgroundColor: Colors.redAccent),
  menu5(image: "assets/images/5.png", backgroundColor: Colors.purpleAccent),
  menu6(image: "assets/images/6.png", backgroundColor: Colors.orangeAccent),
  menu7(image: "assets/images/7.png", backgroundColor: Colors.blueGrey);
  final String image;
  final Color backgroundColor;
  const Foodpic({required this.image, required this.backgroundColor });
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
  Foodmenu(
    name: 'Pizza',
    type: 'Fast Food',
    component: 'Dough, Cheese, Toppings',
    price: 100,
    foodpic: Foodpic.menu2,
    backgroundColor: Foodpic.menu2.backgroundColor,
  ),
  Foodmenu(
    name: 'Pasta',
    type: 'Italian',
    component: 'Noodles, Sauce, Cheese',
    price: 80,
    foodpic: Foodpic.menu3,
    backgroundColor: Foodpic.menu3.backgroundColor,
  ),
  Foodmenu(
    name: 'Salad',
    type: 'Healthy',
    component: 'Vegetables, Dressing',
    price: 40,
    foodpic: Foodpic.menu4,
    backgroundColor: Foodpic.menu4.backgroundColor,
  ),
  Foodmenu(
    name: 'Sushi',
    type: 'Japanese',
    component: 'Rice, Fish, Seaweed',
    price: 120,
    foodpic: Foodpic.menu5,
    backgroundColor: Foodpic.menu5.backgroundColor,
  ),
];
