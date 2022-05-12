import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String commentId;
  final String userId;
  final String commentText;
  final DateTime commentDate;
  Comment({
    this.commentId = '',
    required this.userId,
    required this.commentText,
    required this.commentDate,
  });

  Map<String, dynamic> toJson() => {
        'commentId': commentId,
        'userId': userId,
        'commentText': commentText,
        'commentDate': commentDate,
      };

  static Comment fromJson(Map<String, dynamic> json) => Comment(
        commentId: json['commentId'],
        userId: json['userId'],
        commentText: json['commentText'],
        commentDate: (json['commentDate'] as Timestamp).toDate(),
      );
}
