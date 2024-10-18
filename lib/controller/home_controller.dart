import 'package:get/get.dart';

import '../helper/dp_helper.dart';
import '../helper/google_services.dart';
import '../modal/home_modal.dart';

class HabitController extends GetxController {
  var habits = <HabitModal>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHabits();
  }

  Future<void> loadHabits() async {
    final habitList = await DatabaseService.databaseService.getHabits();
    habits.assignAll(habitList);
  }

  Future<void> insertHabit(HabitModal habit) async {
    await DatabaseService.databaseService.addHabit(habit);
    loadHabits();
  }

  Future<void> updateHabitTracker(HabitModal habit) async {
    await DatabaseService.databaseService.updateHabit(habit);
    loadHabits();
  }

  Future<void> deleteHabitTracker(int id) async {
    await DatabaseService.databaseService.deleteHabit(id);
    loadHabits();
  }


  void markProgress(HabitModal habit) {
    habit.progress = habit.progress + 1;
    DatabaseService.databaseService.updateHabit(habit);
  }

  void allDataStoreToDataBase()
  {
    for(HabitModal habit in habits)
    {
      GoogleFirebaseServices.googleFirebaseServices.allDataStore(habit);
    }
  }
}
