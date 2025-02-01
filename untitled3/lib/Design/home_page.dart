import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/Design/department_screen.dart';
import 'package:untitled3/Design/login_signup.dart';
import 'package:untitled3/Design/status_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void navigatedBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex != 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => StatusPage()));
    }
  }

  final list_page = [
    // Home Page
    HomePage(),
    // Status Page
    StatusPage(),
  ];

  // Function to record video
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Union Bank',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height:600,child: DepartmentScreen()),
            // Record video button below the app bar
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: ElevatedButton.icon(
            //     onPressed: _recordVideo,
            //     icon: Icon(Icons.videocam),
            //     label: Text('Record Video'),
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.red,
            //       foregroundColor: Colors.white,
            //     ),
            //   ),
            // ),
            // Record video button above the bottom bar
            Padding(
              padding: const EdgeInsets.all(16.0),
               child: ElevatedButton.icon(
                 onPressed: (){
                  FirebaseAuth.instance.signOut();
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginSignup()));
                 },
                 icon: Icon(Icons.videocam),
                 label: Text('SignOut'),
                 style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.red,
                   foregroundColor: Colors.white,
                 ),
                  ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: navigatedBottomBar,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.start),
            label: 'Status',
          ),
        ],
      ),
    );
  }
}
