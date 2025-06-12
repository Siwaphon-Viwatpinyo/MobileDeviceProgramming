import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset("assets/images/1.png", height: 150, width: 150),
        const SizedBox(),
        Text("ไข่กะทะ",textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.teal,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(
          height: 20,
        ),
        Image.asset("assets/images/2.png", height: 150, width: 150),
        const SizedBox(),
                Text("ชุดสลัดพร้อมเคครื่องดื่ม",textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.teal,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 20,),
        Image.asset("assets/images/3.png", height: 150, width: 150),
        const SizedBox(),
                Text("สเต็กเนื้อวากิว",textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.teal,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(),

      ],
    );
  }
}
