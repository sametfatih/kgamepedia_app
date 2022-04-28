import 'package:flutter/material.dart';

class UserInformationPage extends StatelessWidget {
  const UserInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('Kullanıcı bilgileri gelecek.'),
        ),
      ),
    );
  }
}
