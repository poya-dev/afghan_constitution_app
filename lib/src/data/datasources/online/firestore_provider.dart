import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

class FirestoreProvider {
  Future<QuerySnapshot?> readItems(String lang) async {
    final faData = await _firebaseFirestore
        .collection("app_data")
        .orderBy("order", descending: false)
        .get();
    final enData = await _firebaseFirestore
        .collection("en_app_data")
        .orderBy("order", descending: false)
        .get();
    final psData = await _firebaseFirestore
        .collection("pa_app_data")
        .orderBy("order", descending: false)
        .get();
    if (lang == 'en') {
      return enData;
    } else if (lang == 'fa') {
      return faData;
    } else if (lang == 'ps') {
      return psData;
    }
  }
}
