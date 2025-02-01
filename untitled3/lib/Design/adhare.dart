import 'package:flutter/material.dart';
//import 'package:untitled3/Design/home_page.dart';
import 'package:untitled3/Design/signup_page.dart';

class Adhare extends StatefulWidget {
  const Adhare({super.key});

  @override
  State<Adhare> createState() => _AdhareState();
}

class _AdhareState extends State<Adhare> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Aadhaar Verification',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Ink.image(
                image: AssetImage('assets/aadhaar.jpeg'),
                height: 100,
                width: 100),
            Padding(padding: EdgeInsets.all(15)),
            Padding(padding: EdgeInsets.only(left: 10, right: 10)),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Aadhaar Number',
                  labelText: 'Aadhaar Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  //////trigger adhar api that send otp
                },
                child: Text(
                  'Verification', //<- Verification
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w400),
                )),
            const SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'OTP',
                  labelText: 'OTP',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  ///////verify the otp and enter the further process
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.red, width: 2),
                ),
                child: Text(
                  'Verification', //<- Verification
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w800),
                )),
          ],
        ),
      ),
    );
  }
}
