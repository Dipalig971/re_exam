import 'package:path/path.dart';
import 'package:re_exam/modal/home_modal.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService databaseService = DatabaseService._internal();
  static Database? _database;

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    final path = join(await getDatabasesPath(), 'habits.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE habits (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            targetDays INTEGER,
            progress INTEGER
          )
        ''');
      },
    );
  }

  Future<int> addHabit(HabitModal habit) async {
    final db = await database;
    return await db.insert('habits', habit.toMap());
  }

  Future<List<HabitModal>> getHabits() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('habits');
    return maps.map((map) => HabitModal.fromMap(map)).toList();
  }

  Future<int> updateHabit(HabitModal habit) async {
    final db = await database;
    return await db.update('habits', habit.toMap(), where: 'id = ?', whereArgs: [habit.id]);
  }

  Future<int> deleteHabit(int id) async {
    final db = await database;
    return await db.delete('habits', where: 'id = ?', whereArgs: [id]);
  }
}
