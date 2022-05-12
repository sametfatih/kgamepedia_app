import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kgamepedia/models/user.dart';
import 'package:kgamepedia/utils/file_utils.dart';
import 'package:kgamepedia/widgets/my_appbars.dart';

class UserInformationPage extends StatefulWidget {
  final KgameUser currentUser;
  const UserInformationPage({Key? key, required this.currentUser}) : super(key: key);

  @override
  State<UserInformationPage> createState() => _UserInformationPageState();
}

class _UserInformationPageState extends State<UserInformationPage> {
  String tempUserInfo = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: myAppBarB(context, 'Kullanıcı Bilgileri'),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
          child: Center(
            child: Material(
              elevation: 8.0,
              borderRadius: BorderRadius.circular(12.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    myText('${widget.currentUser.userName} ${widget.currentUser.userSurname}'),
                    myText('${widget.currentUser.userAge}'),
                    myText('${widget.currentUser.userCity} | ${widget.currentUser.userCountry}'),
                    TextButton(
                      onPressed: () {
                        FileUtils.saveToFile('user_info', widget.currentUser.toJson().toString());
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Bilgileriniz user_info.txt dosyasına kaydedildi.',
                            style: TextStyle(color: Colors.black),
                          ),
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        ));
                      },
                      child: Text('Kgames veritabanındaki bilgilerimi txt olarak kaydet.'),
                    ),
                    TextButton(
                      onPressed: () {
                        FileUtils.readFromFile('user_info').then((value) {
                          setState(() {
                            tempUserInfo = value;
                          });
                        });
                      },
                      child: Text('Veritabanındaki bilgilerimi göster.'),
                    ),
                    Expanded(
                      child: Material(
                          elevation: 8.0,
                          borderRadius: BorderRadius.circular(4.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                tempUserInfo,
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                          )),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          tempUserInfo = '';
                          FileUtils.deleteFile('user_info');
                        });
                      },
                      child: Text('Bilgilerimi sil .'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget myText(String text) => Text(
        text,
        style: TextStyle(fontSize: 18.0),
      );
}
