import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';

class DatabaseHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        date TEXT,
        amount INTEGER,
        caption TEXT,
        status TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('cashflow.db', version: 1, onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  // Create new item
  static Future<int> createItem(String date, int amount, String caption, String status) async {
    final db = await DatabaseHelper.db();

    final data = {'date': date, 'amount': amount, 'caption': caption, 'status': status};
    final id = await db.insert('items', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DatabaseHelper.db();
    return db.query('items', orderBy: 'id');
  }

  // Read a single item by id
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await DatabaseHelper.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(int id, String date, int amount, String caption, String status) async {
    final db = await DatabaseHelper.db();

    final data = {
      'date': date,
      'amount': amount,
      'caption': caption,
      'status': status,
      'createdAt': DateTime.now().toString(),
    };

    final result = await db.update('items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete('items', where: "id = ?", whereArgs: [id]);
    } catch (e) {
      print("Something went wrong when deleting an item: $e");
    }
  }
}
