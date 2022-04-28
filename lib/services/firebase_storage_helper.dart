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

  //Oyun widgeti için backgroundimage getiriyoruz
  Future<String> getGameBacgroundImageURL(String imageName, String screenshot) async {
    final ref = database.ref('game_screenshots').child('${imageName}_$screenshot.jpg');
    String url = await ref.getDownloadURL();
    return url;
  }

  //Oyun ekranındaki alt kısımdaki screenshotImage'in URL'lerini oyuna göre FirebaseStorage'den getiriyoruz.
  Future<List<String>> getGameScreenshotImageURLS(String imageName) async {
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

    List<String> urlList = [ref1, ref2, ref3, ref4, ref5];

    return urlList;
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
