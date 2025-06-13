import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () {
              print('Button clicked!');
            },
            child: const Text(
              'Click',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 10),

          FilledButton(
            style: TextButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {},
            child: const Text(
              "Click",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 10),

          OutlinedButton(
            style: TextButton.styleFrom(backgroundColor: Colors.yellowAccent),
            onPressed: () {},
            child: const Text(
              "Click",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 10),
          ElevatedButton(
            style: TextButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: () {},
            child: const Text(
              "Click",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
