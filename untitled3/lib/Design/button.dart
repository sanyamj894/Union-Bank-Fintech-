import 'package:flutter/material.dart';
import 'package:untitled3/Design/faq_page.dart';

class Button extends StatelessWidget {
  final String name;

  const Button({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FaqPage(department: name)),
        );
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.blue, // Added background color
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black), // Border for visibility
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
