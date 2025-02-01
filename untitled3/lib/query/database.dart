import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled3/query/data.dart';

class DataBase{
  final db = FirebaseFirestore.instance;
  Future<void> addDetails(String user) async {
    try{
      await db.collection(user).doc("profile").set({});
      await db.collection(user).doc("ticket").set({});
    } catch(e){

    }
  }

  Future<void> getDetail(String user,String docs) async {
    try {
      final datadb = await db.collection(user).doc(docs).get();
      Data.profile = datadb.data() as Map<String, dynamic>;
    } catch (e) {

    }
  }

    Future<void> fetchFAQ(String department) async {
      try {
        final ref = db.collection("FAQ").doc(department);

        // Fetch the transaction data
        var doc = await ref.get();
        if (doc.exists) {
          // Get the data as a Map
          Map<String, dynamic> faqData =
          doc.data() as Map<String, dynamic>;
          Data.faqData=faqData;
          print("All transactions fetched and saved locally!");
        } else {
          print("No transaction data found.");
        }
      } catch (e) {
        print('Error fetching and saving transactions: ${e.toString()}');
      }
    }
}