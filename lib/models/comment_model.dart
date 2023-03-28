import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String id;
  final String postId;
  final String authorId;
  final String authorName;
  final String authorImageUrl;
  final String content;
  final Timestamp timestamp;

  Comment({
    required this.id,
    required this.postId,
    required this.authorId,
    required this.authorName,
    required this.authorImageUrl,
    required this.content,
    required this.timestamp,
  });

  factory Comment.fromDoc(DocumentSnapshot doc) {
    return Comment(
      id: doc.id,
      postId: doc['postId'],
      authorId: doc['authorId'],
      authorName: doc['authorName'],
      authorImageUrl: doc['authorImageUrl'],
      content: doc['content'],
      timestamp: doc['timestamp'],
    );
  }
}
