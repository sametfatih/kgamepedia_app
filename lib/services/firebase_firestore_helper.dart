import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kgamepedia/models/category.dart';
import 'package:kgamepedia/models/game.dart';
import 'package:kgamepedia/models/user.dart';

import 'url_launcher.dart';

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

  Widget textBuild({
    required AsyncSnapshot snapshot,
    Color color = Colors.black,
    double fontSize = 14.0,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    if (snapshot.hasData) {
      final data = snapshot.data;
      return data == null
          ? Text('Data not found.')
          : Text(
              data.toString(),
              style: TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
            );
    } else {
      return Text('Yükleniyor');
    }
  }

  Widget buyButtonBuild({required AsyncSnapshot snapshot}) {
    if (snapshot.hasData) {
      final data = snapshot.data;
      return data == null
          ? Center(
              child: Text('Data not found'),
            )
          : ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFFFFDE15))),
              onPressed: () {
                launchURL(data);
              },
              child: Text(
                'Satın Al',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            );
    } else {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Yükleniyor...'),
        ),
      );
    }
  }
}

class FirebaseUserHelper extends FirebaseHelper {
  Future<KgameUser?> readUser(String userId) async {
    final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);
    final snapshot = await userDoc.get();
    if (snapshot.exists) {
      return KgameUser.fromJson(snapshot.data()!);
    }
    return null;
  }
}

class FirebaseCategoryHelper extends FirebaseHelper {
  Stream<List<Categories?>> readCategories() {
    return database
        .collection('categories')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Categories.fromJson(doc.data())).toList());
  }

  Stream<List<Game?>> readGamesForCategory(String categoryName) {
    return FirebaseFirestore.instance
        .collection('games')
        .where('gameCategory', isEqualTo: categoryName)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((game) => Game.fromJson(game.data())).toList());
  }
}
