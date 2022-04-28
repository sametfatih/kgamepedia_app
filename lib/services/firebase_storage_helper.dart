import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageHelper {
  FirebaseStorage database = FirebaseStorage.instance;

  //Oyun ekranındaki sol üstteki image'in URL'ini oyuna göre FirebaseStorage'den getiriyoruz.
  Future<String> getGameImageURL(String imageName) async {
    final ref = database.ref('game_images').child('$imageName.jpg');
    String url = await ref.getDownloadURL();
    // print('$imageName.jpg adlı image yüklendi download link => $url');
    return url;
  }

  //Oyun ekranındaki alt kısımdaki screenshotImage'in URL'ini oyuna göre FirebaseStorage'den getiriyoruz.
  Future<String> getGameScreenshotImageURL(String imageName, String screenshotId) async {
    final ref = database.ref('game_screenshots').child('${imageName}_$screenshotId.jpg');
    String url = await ref.getDownloadURL();
    //print('${imageName}_${screenshotId}.jpg adlı image yüklendi download link => $url');
    return url;
  }

  //Game Maker ekranında ki logoyu oyuna göre getiriyoruz
  Future<String> getGameMakerImageURL(String gameID) async {
    return FirebaseFirestore.instance.collection('games').doc(gameID).get().then((value) async {
      final ref = database.ref('game_maker_logos').child('${value['gameMakerId']}.jpg');
      String? url = await ref.getDownloadURL();
      //print('${value['gameMakerId']}         $url');
      //print('${imageName}_${screenshotId}.jpg adlı image yüklendi download link => $url');
      return url;
    });
  }

  Future<String> getCategoryImageURL(String imageName) async {
    final ref = database.ref('category_images').child('$imageName.jpg');
    String url = await ref.getDownloadURL();
    // print('$imageName.jpg adlı image yüklendi download link => $url');
    return url;
  }
}
