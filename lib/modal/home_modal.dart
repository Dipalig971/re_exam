class HabitModal {
  int? id;
  String name;
  int targetDays;
  int progress;

  HabitModal({this.id, required this.name, required this.targetDays, required this.progress});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'targetDays': targetDays,
      'progress': progress,
    };
  }

  factory HabitModal.fromMap(Map<String, dynamic> map) {
    return HabitModal(
      id: map['id'],
      name: map['name'],
      targetDays: map['targetDays'],
      progress: map['progress'],
    );
  }
}
