import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE favorites(
        id INTEGER PRIMARY KEY NOT NULL,
        name TEXT, 
        shortName TEXT,
        tla TEXT, 
        crest TEXT,
        address TEXT,
        website TEXT
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'ddm3.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item
  static Future<int> createFavorite(int id, String name, String shortName,
      String tla, String crest, String address, String website) async {
    final db = await DatabaseHelper.db();

    final data = {
      'id': id,
      'name': name,
      'shortName': shortName,
      'tla': tla,
      'crest': crest,
      'address': address,
      'website': website,
    };
    final tableId = await db.insert('favorites', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return tableId;
  }

  // Read all favorites
  static Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await DatabaseHelper.db();
    return db.query('favorites', orderBy: "id");
  }

  // Get a single favorite by id
  static Future<List<Map<String, dynamic>>> getFavorite(int id) async {
    final db = await DatabaseHelper.db();
    return db.query('favorites', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an favorite by id
  static Future<int> updateFavorite(int id, String? name, String? shortName,
      String? tla, String? crest, String? address, String? website) async {
    final db = await DatabaseHelper.db();

    final data = {
      'id': id,
      'name': name,
      'shortName': shortName,
      'tla': tla,
      'crest': crest,
      'address': address,
      'website': website,
    };

    final result =
        await db.update('favorites', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteFavorite(int id) async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete("favorites", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Algo deu errado ao excluir um item: $err");
    }
  }
}
