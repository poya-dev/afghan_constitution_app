import 'package:afghanistan_law_app/src/models/favorite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteProvider {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'law.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE favorite(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, content TEXT NOT NULL, lang TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertFavorite(FavoriteModel favorite) async {
    int result = 0;
    final Database db = await initializeDB();
    final res = await db.query(
      "favorite",
      where: "title = ? AND lang = ?",
      whereArgs: [favorite.title, favorite.lang],
    );
    if (res.isEmpty) {
      result = await db.insert(
        'favorite',
        favorite.toMap(),
      );
      return result;
    }
    return result;
  }

  Future<List<Map<String, dynamic>>> retrieveFavorite(String lang) async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.query('favorite', where: 'lang = ?', whereArgs: [lang]);
    return queryResult;
  }

  Future<void> deleteFavorite(String title, String lang) async {
    final db = await initializeDB();
    await db.delete('favorite',
        where: "title = ? AND lang = ?", whereArgs: [title, lang]);
  }

  Future<bool> isFavorite(String title, String lang) async {
    final db = await initializeDB();
    var result = await db.query(
      "favorite",
      where: "title = ? AND lang = ?",
      whereArgs: [title, lang],
    );
    return result.isNotEmpty ? true : false;
  }
}
