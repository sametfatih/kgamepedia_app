import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kgamepedia/models/user.dart';

class UserInformationPage extends StatelessWidget {
  final KgameUser currentUser;
  const UserInformationPage({Key? key, required this.currentUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ad soyad : ${currentUser.userName} ${currentUser.userSurname}'),
            Text('Yaş : ${currentUser.userAge}'),
            Text('Şehir : ${currentUser.userCity}'),
            Text('Ülke : ${currentUser.userCountry}'),
            Text('Email : ${currentUser.userEmail}'),
            Text('password : ${currentUser.userPassword}'),
          ],
        ),
      ),
    );
  }
}
