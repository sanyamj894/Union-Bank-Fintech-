import 'package:flutter/material.dart';
import 'package:untitled3/Design/button.dart';
import 'package:untitled3/query/data.dart';
import 'package:untitled3/query/storage.dart';

class DepartmentScreen extends StatelessWidget {
  const DepartmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible( // Wrap GridView.count in Expanded
            child: GridView.count(
              padding: const EdgeInsets.all(10),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                Button(name: "Loan"),
                Button(name: "Deposit"),
                Button(name: "Investment"),
                Button(name: "Fraud"),
                Button(name: "Account"),
                Button(name: "Other"),
              ],
            ),
          ),
          ElevatedButton(onPressed: () {}, child: Text("Chat With Us")),
          Visibility(
            visible: Data.visible,
            child: ElevatedButton(
              onPressed: () {
                AppWriteStorageService().recordVideo(context);
              },
              child: Text("Record Your Issues"),
            ),
          ),
        ],
      ),
    );
  }
}
