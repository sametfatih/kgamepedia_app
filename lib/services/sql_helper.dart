import 'package:firebase_storage/firebase_storage.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<sql.Database> db() async {
    return sql.openDatabase('kgames.db', version: 1, onCreate: (sql.Database database, int version) async {
      await database.execute(""" CREATE TABLE 
        game_images(
        gameId TEXT PRIMARY KEY UNIQUE NOT NULL,
        gameImage TEXT NOT NULL,
        screenshot1 TEXT NOT NULL,
        screenshot2 TEXT NOT NULL,
        screenshot3 TEXT NOT NULL,
        screenshot4 TEXT NOT NULL,
        screenshot5 TEXT NOT NULL
        ) """);

      await database.execute(""" CREATE TABLE 
        game_maker_images(
        gameMakerId TEXT PRIMARY KEY UNIQUE NOT NULL,
        gameMakerImage TEXT NOT NULL
        ) """);
      await database.execute(""" CREATE TABLE
        categories(
        categoryId TEXT PRIMARY KEY UNIQUE NOT NULL,
        categoryImage TEXT NOT NULL
        ) """);
    });
  }

  static Future<List<Map<String, dynamic>>> getImages(String tableName) async {
    final db = await SQLHelper.db();
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return maps;
  }
}

class SQLGameHelper extends SQLHelper {
  static Future addGameImageTable(String gameId, String gameImage, String screenshot1, String screenshot2,
      String screenshot3, String screenshot4, String screenshot5) async {
    final db = await SQLHelper.db();
    final data = {
      'gameId': gameId,
      'gameImage': gameImage,
      'screenshot1': screenshot1,
      'screenshot2': screenshot2,
      'screenshot3': screenshot3,
      'screenshot4': screenshot4,
      'screenshot5': screenshot5,
    };
    await db.insert('game_images', data, conflictAlgorithm: sql.ConflictAlgorithm.ignore);
  }

  static Future addGameImageUrls(String imageName) async {
    FirebaseStorage database = FirebaseStorage.instance;

    String gameimage = await database.ref('game_images').child('$imageName.jpg').getDownloadURL();
    String ref1 =
        await database.ref('game_screenshots').child('${imageName}_screenshot_1.jpg').getDownloadURL();
    String ref2 =
        await database.ref('game_screenshots').child('${imageName}_screenshot_2.jpg').getDownloadURL();
    String ref3 =
        await database.ref('game_screenshots').child('${imageName}_screenshot_3.jpg').getDownloadURL();
    String ref4 =
        await database.ref('game_screenshots').child('${imageName}_screenshot_4.jpg').getDownloadURL();
    String ref5 =
        await database.ref('game_screenshots').child('${imageName}_screenshot_5.jpg').getDownloadURL();

    await SQLGameHelper.addGameImageTable(imageName, gameimage.toString(), ref1.toString(), ref2.toString(),
        ref3.toString(), ref4.toString(), ref5.toString());
    print('$imageName için Urls getirildi');
  }

  static Future<List<Map<String, dynamic>>> getGameImagesForId(String gameId) async {
    final db = await SQLHelper.db();
    final maps = await db.query('game_images', where: "gameId = ?", whereArgs: [gameId], limit: 1);
    return maps;
  }
}

class SQLMakerHelper extends SQLHelper {
  static Future addGameMakerImageTable(String gameMakerId, String gameMakerImage) async {
    final db = await SQLHelper.db();
    final data = {
      'gameMakerId': gameMakerId,
      'gameMakerImage': gameMakerImage,
    };
    await db.insert('game_maker_images', data, conflictAlgorithm: sql.ConflictAlgorithm.ignore);
  }

  static Future addGameMakerImageUrls(String gameMakerId) async {
    FirebaseStorage database = FirebaseStorage.instance;
    String ref = await database.ref('game_maker_logos').child('$gameMakerId.jpg').getDownloadURL();

    await SQLMakerHelper.addGameMakerImageTable(gameMakerId, ref.toString());
    print('$gameMakerId için Urls getirildi');
  }

  static Future<List<Map<String, dynamic>>> getGameMakerImagesForId(String gameMakerId) async {
    final db = await SQLHelper.db();
    final maps =
        await db.query('game_maker_images', where: "gameMakerId = ?", whereArgs: [gameMakerId], limit: 1);
    return maps;
  }
}

class SQLCategoryHelper extends SQLHelper {
  static Future addCategoryImageTable(String categoryId, String categoryImage) async {
    final db = await SQLHelper.db();
    final data = {
      'categoryId': categoryId,
      'categoryImage': categoryImage,
    };
    await db.insert('categories', data, conflictAlgorithm: sql.ConflictAlgorithm.ignore);
  }

  static Future addCategoryImageUrls(String categoryId) async {
    FirebaseStorage database = FirebaseStorage.instance;
    String ref = await database.ref('category_images').child('$categoryId.jpg').getDownloadURL();

    await SQLCategoryHelper.addCategoryImageTable(categoryId, ref.toString());
    print('$categoryId için Urls getirildi');
  }

  static Future<List<Map<String, dynamic>>> getCategoryImagesForId(String categoryId) async {
    final db = await SQLHelper.db();
    final maps = await db.query('categories', where: "categoryId = ?", whereArgs: [categoryId], limit: 1);
    return maps;
  }
}
