// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String title;
  final String imageUrl;
  final String authorId;
  final String authorName;
  final String authorImageUrl;
  final Timestamp timestamp;
  final List<String> likes;
  final List<String> comments;

  Post({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.authorId,
    required this.authorName,
    required this.authorImageUrl,
    required this.timestamp,
    required this.likes,
    required this.comments,
  });

  factory Post.fromDoc(DocumentSnapshot doc) {
    return Post(
      id: doc.id,
      title: doc['title'],
      imageUrl: doc['imageUrl'],
      authorId: doc['authorId'],
      authorName: doc['authorName'],
      authorImageUrl: doc['authorImageUrl'],
      timestamp: doc['timestamp'],
      likes: List<String>.from(doc['likes']),
      comments: List<String>.from(doc['comments']),
    );
  }
}
