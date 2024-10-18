import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:re_exam/modal/home_modal.dart';

class FirebaseHelper {
  static final CollectionReference HabitCollection =
  FirebaseFirestore.instance.collection('habit');

  static Future<void> syncExpenseToFirestore(HabitModal habit) async {
    await HabitCollection.doc(habit.id.toString()).set(habit.toMap());
  }

  static Future<void> deleteExpenseFromFirestore(int id) async {
    await HabitCollection.doc(id.toString()).delete();
  }
}