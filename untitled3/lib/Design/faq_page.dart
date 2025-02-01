import 'package:flutter/material.dart';
import 'package:untitled3/Design/faq_button.dart';
import 'package:untitled3/query/data.dart';
import 'package:untitled3/query/storage.dart';

class FaqPage extends StatefulWidget {
  final String department;
  const FaqPage({super.key, required this.department});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded( // ✅ Wrap FaqButton to prevent infinite height
            child: FaqButton(
              department: widget.department,
            ),
          ),
          Visibility(
            visible: Data.visible,
            child: Column(
              children: [
                ElevatedButton(onPressed: () {}, child: Text("Chat With Us")),
                ElevatedButton(
                    onPressed: () {
                      AppWriteStorageService().recordVideo(context);
                    },
                    child: Text("Record Your Issues")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
