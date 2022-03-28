import 'package:flutter/material.dart';

import '../widgets/my_appbars.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePAgeState createState() => _ProfilePAgeState();
}

class _ProfilePAgeState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar(context, 'Profil'),
    );
  }
}
