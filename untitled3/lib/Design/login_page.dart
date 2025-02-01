import 'package:flutter/material.dart';
import 'package:untitled3/Design/department_screen.dart';
import 'package:untitled3/Design/home_page.dart';
import 'package:untitled3/query/biometric.dart';
import 'package:untitled3/query/fetchdata.dart';

/*
Add aadhar verification on the button in line number 61.
*/
class LoginPage extends StatefulWidget {
  final bool page;

  const LoginPage({super.key, required this.page});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obsure = true;
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Ink.image(
                image: AssetImage('assets/login.jpeg'),
                height: 200,
                width: 200,
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  labelText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                    15,
                  )),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: password,
                obscureText: _obsure,
                decoration: InputDecoration(
                  hintText: 'Password',
                  labelText: 'Password',
                  prefixIcon: IconButton(
                    icon:
                        Icon(_obsure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obsure = !_obsure;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.red,
                      )),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    String res = "no check";
                    if (widget.page) {
                      res = await Detail().login(
                          emailAddress.text.trim(), password.text.trim());
                    } else {
                      res = await Detail().signIn(
                          emailAddress.text.trim(), password.text.trim());
                    }
                    print(res);
                    if (res == "") {
                      if (widget.page) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DepartmentScreen()));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(res)),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.red, width: 2),
                      )),
                  child: Text(
                    'Verification', //<- Verification
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 15),
                  )),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: widget.page,
                child: ElevatedButton(
                  onPressed: () async {
                    final response = await BioMetricAuth().bioMetrics();
                    if (response == "") {
                      if (BioMetricAuth.user != null &&
                          BioMetricAuth.password != null) {
                        final res = await Detail().login(
                          BioMetricAuth.user!,
                          BioMetricAuth.password!,
                        );
                        if (res == "") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(res)),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("User credentials are missing.")),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(response)),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.red, width: 2),
                    ),
                  ),
                  child: Text(
                    'Face ID',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Ink.image(
                image: AssetImage('assets/vyon.png'),
                height: 200,
                width: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
