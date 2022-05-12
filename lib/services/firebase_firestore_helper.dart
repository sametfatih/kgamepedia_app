import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kgamepedia/models/category.dart';
import 'package:kgamepedia/models/comment.dart';
import 'package:kgamepedia/models/game.dart';

import '../models/user.dart';

class FirebaseHelper {
  FirebaseFirestore database = FirebaseFirestore.instance;
}

class FirebaseGameHelper extends FirebaseHelper {
  Future<Game?> readGame(String gameId) async {
    final docGame = FirebaseFirestore.instance.collection('games').doc(gameId);
    final snapshot = await docGame.get();
    if (snapshot.exists) {
      return Game.fromJson(snapshot.data()!);
    }
    return null;
  }

  //Oyunlar koleksiyonundaki oyunların herbirini json olarak listeleyerek getirir.
  Stream<List<Game>> readGames() {
    return database
        .collection('games')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Game.fromJson(doc.data())).toList());
  }

  //Oyunlar koleksiyonundaki oyunları Search page için json olarak listeleyerek getirir.
  Stream<List<Game>> readGamesForSearch(String userSelect, String tempSearch, List category) {
    return database
        .collection('games')
        .where(
          userSelect,
          isGreaterThanOrEqualTo: tempSearch,
          isLessThan: "$tempSearch\uf7ff",
        )
        .orderBy(
          userSelect,
          descending: !category[3],
        )
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Game.fromJson(doc.data())).toList());
  }

  //Oyun sayfasındaki yorumları getiriyor.
  Stream<List<Comment>> readComments(String gameId, int limit) {
    return FirebaseFirestore.instance
        .collection('games')
        .doc(gameId)
        .collection('comments')
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Comment.fromJson(doc.data())).toList());
  }

  Future<String> getGameName(String gameID) async {
    DocumentReference documentReference = database.collection('games').doc(gameID);
    DocumentSnapshot snapshot = await documentReference.get();
    return snapshot.get('gameName');
  }

  Future<String> getGameDescription(String gameID) async {
    DocumentReference documentReference = database.collection('games').doc(gameID);
    DocumentSnapshot snapshot = await documentReference.get();
    return await snapshot.get('gameDescription');
  }

  Future<String> getGameMakerName(String gameID) async {
    DocumentReference documentReference = database.collection('games').doc(gameID);
    DocumentSnapshot snapshot = await documentReference.get();
    return snapshot.get('gameMakerName');
  }

  Future<String> getGameMakerDesc(String gameID) async {
    DocumentReference documentReference = database.collection('games').doc(gameID);
    DocumentSnapshot snapshot = await documentReference.get();
    return snapshot.get('gameMakerDesc');
  }

  Future<String> getGameLink(String gameID) async {
    DocumentReference documentReference = database.collection('games').doc(gameID);
    DocumentSnapshot snapshot = await documentReference.get();
    return snapshot.get('gameLink');
  }

  Future<List> getPlatforms(String gameID) async {
    DocumentReference documentReference = database.collection('games').doc(gameID);
    DocumentSnapshot snapshot = await documentReference.get();
    final platforms = List.from(snapshot.get('platforms'));
    return platforms;
  }
}

class FirebaseUserHelper extends FirebaseHelper {
  static Future<KgameUser?> readUser(String userId) async {
    final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);
    final snapshot = await userDoc.get();
    if (snapshot.exists) {
      return KgameUser.fromJson(snapshot.data()!);
    }
    return null;
  }

  static Stream<List<KgameUser>> readUsers() {
    return FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => KgameUser.fromJson(doc.data())).toList());
  }
}

class FirebaseCategoryHelper extends FirebaseHelper {
  Stream<List<Categories?>> readCategories() {
    return database
        .collection('categories')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Categories.fromJson(doc.data())).toList());
  }

  Stream<List<Game>> readGamesForCategory(String categoryName) {
    return FirebaseFirestore.instance
        .collection('games')
        .where('gameCategory', isEqualTo: categoryName)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((game) => Game.fromJson(game.data())).toList());
  }
}
