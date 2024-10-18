import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';
import '../helper/firebase_helper.dart';
import '../modal/home_modal.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HabitController habitController = Get.put(HabitController());

    final TextEditingController nameController = TextEditingController();
    final TextEditingController targetController = TextEditingController();

    final TextEditingController editNameController = TextEditingController();
    final TextEditingController editTargetController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: const Icon(Icons.menu, color: Colors.white),
        title: const Text('Habit Tracker', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: IconButton(
              onPressed: () {
                habitController.allDataStoreToDataBase();
              },
              icon: const Icon(Icons.sync, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: habitController.habits.length,
          itemBuilder: (context, index) {
            final habit = habitController.habits[index];
            return Card(
              child: ListTile(
                title: Text(habit.name),
                subtitle: Text('${habit.progress}/${habit.targetDays} days completed'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: () {
                        habitController.markProgress(habit);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        editNameController.text = habit.name;
                        editTargetController.text = habit.targetDays.toString();

                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Edit Habit'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: editNameController,
                                    decoration: const InputDecoration(
                                      hintText: 'Habit Name',
                                    ),
                                  ),
                                  TextField(
                                    controller: editTargetController,
                                    decoration: const InputDecoration(
                                      hintText: 'Target Days',
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    final editName = editNameController.text;
                                    final editTarget = int.tryParse(editTargetController.text) ?? 0;

                                    if (editName.isNotEmpty && editTarget > 0) {

                                    final habits=  HabitModal(
                                        name: editName,
                                        targetDays: editTarget,
                                        progress: habit.progress,
                                      );
                                      habitController.updateHabitTracker(
                                        habits,
                                      );
                                      Get.back();
                                    }
                                  },
                                  child: const Text('Update'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text('Cancel'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        habitController.deleteHabitTracker(habit.id!);
                      },
                    ),

                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add New Habit'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'Habit Name',
                      ),
                    ),
                    TextField(
                      controller: targetController,
                      decoration: const InputDecoration(
                        hintText: 'Target Days',
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      final name = nameController.text;
                      final targetDays = int.tryParse(targetController.text) ?? 0;

                      if (name.isNotEmpty && targetDays > 0) {
                        final newHabit = HabitModal(
                          name: name,
                          targetDays: targetDays,
                          progress: 0,
                        );
                        habitController.insertHabit(newHabit);
                      }
                      Get.back();
                    },
                    child: const Text('Save'),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
