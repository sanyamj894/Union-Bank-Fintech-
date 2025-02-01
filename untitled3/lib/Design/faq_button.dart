import 'package:flutter/material.dart';
import 'package:untitled3/query/data.dart';
import 'package:untitled3/query/database.dart';

class FaqButton extends StatefulWidget {
  final String department;

  const FaqButton({super.key, required this.department});

  @override
  State<FaqButton> createState() => _FaqButtonState();
}

class _FaqButtonState extends State<FaqButton> {
  @override
  void initState() {
    super.initState();
    sync();
  }

  Future<void> sync() async {
    try {
      await DataBase().fetchFAQ(widget.department);
      setState(() {}); // Ensures UI updates after fetching data
    } catch (e) {
      print('Error reading transactions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
        centerTitle: true,
      ),
      body: Data.faqData.isEmpty
          ? const Center(child: Text('No FAQ found'))
          : ListView.builder( // ✅ Remove Expanded here
        itemCount: Data.faqData.length,
        itemBuilder: (context, index) {
          var faqData = Data.faqData[index];
          return ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(faqData['question'], style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(faqData['answer']),
              ],
            ),
          );
        },
      ),
    );
  }
}
