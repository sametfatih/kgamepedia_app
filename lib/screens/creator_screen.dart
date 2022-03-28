import 'package:flutter/material.dart';

class CreatorPage extends StatefulWidget {
  static String routeName = '/routeCreatorPage';
  const CreatorPage({Key? key}) : super(key: key);

  @override
  State<CreatorPage> createState() => _CreatorPageState();
}

class _CreatorPageState extends State<CreatorPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onLongPress: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
            child: Center(
              child: Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(12.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          'GELİŞTİRİCİ',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(64.0),
                        elevation: 12.0,
                        child: CircleAvatar(
                          maxRadius: 64,
                          minRadius: 64,
                          backgroundImage: AssetImage('assets/images/user_avatars/creator.jpeg'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          'Samet Fatih GÖZÜM',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Selçuk Üniversitesi Bilgisayar Mühendisliği',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          '2022',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Geri dönmek için herhangi bir yere basılı tut.',
                          style: TextStyle(fontSize: 12, color: Colors.black38),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
