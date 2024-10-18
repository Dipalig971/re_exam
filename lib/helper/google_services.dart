import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:re_exam/modal/home_modal.dart';



class GoogleFirebaseServices {
  static GoogleFirebaseServices googleFirebaseServices =
  GoogleFirebaseServices._();

  GoogleFirebaseServices._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void allDataStore(HabitModal habit) {
    try {
      CollectionReference users = firestore.collection('habit');
      users.doc(habit.id.toString()).set(habit.toMap());
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<QuerySnapshot<Object?>> getData() {
    Stream<QuerySnapshot> usersStream = firestore.collection('habit').snapshots();
    return usersStream;
  }
}