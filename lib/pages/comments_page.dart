import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kgamepedia/widgets/my_appbars.dart';

import '../models/comment.dart';
import '../models/user.dart';
import '../services/firebase_firestore_helper.dart';

class Comments extends StatefulWidget {
  final String gameId;
  const Comments({Key? key, required this.gameId}) : super(key: key);

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final FirebaseGameHelper _gameHelper = FirebaseGameHelper();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: myAppBarB(context, 'yorumlar'),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: StreamBuilder<List<Comment>>(
              stream: _gameHelper.readComments(widget.gameId, 50),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final comments = snapshot.data;
                  return Column(children: comments!.map((comment) => buildComment(comment)).toList());
                } else {
                  return Text('Yükleniyor');
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  //oyun sayfasındaki yorum widgetinin build edilmesi.
  Widget buildComment(Comment comment) {
    Widget userNamebuild() => FutureBuilder<KgameUser?>(
        future: FirebaseUserHelper.readUser(comment.userId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data;
            return Text(user!.userName, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500));
          } else {
            return Text('Yükleniyor');
          }
        });

    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Material(
            elevation: 6.0,
            borderRadius: BorderRadius.circular(24),
            child: CircleAvatar(
              minRadius: 24,
              maxRadius: 24,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              backgroundImage: AssetImage('assets/images/user_avatars/male_avatar.png'),
            ),
          ),
          VerticalDivider(),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    userNamebuild(),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(DateFormat('- MMM d, h:mm').format(comment.commentDate)),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Text(comment.commentText, style: TextStyle(fontSize: 14.0)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
