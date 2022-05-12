import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kgamepedia/widgets/my_appbars.dart';

import '../app_settings_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool switchValue = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: myAppBarB(context, 'ayarlar'),
        body: Column(
          children: [
            ListTile(
              title: Text('Kullanıcı ayarları (Eklenecek)'),
              trailing: Icon(Icons.person_outlined, color: Theme.of(context).iconTheme.color),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AppSettingsPage()));
              },
              child: ListTile(
                title: Text('Uygulama ayarları'),
                trailing: Icon(Icons.settings_outlined, color: Theme.of(context).iconTheme.color),
              ),
            ),
            ListTile(
              title: Text('Güvenlik ve gizlilik (Eklenecek)'),
              trailing: Icon(Icons.shield_outlined, color: Theme.of(context).iconTheme.color),
            ),
            GestureDetector(
              onTap: () async {
                Navigator.pop(context);
                Navigator.pop(context);
                await FirebaseAuth.instance.signOut();
              },
              child: ListTile(
                title: Text('Çıkış yap'),
                trailing: Icon(Icons.logout_rounded, color: Theme.of(context).iconTheme.color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
