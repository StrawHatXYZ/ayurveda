// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  String title;
  String imageUrl;
  String authorId;

  Timestamp timestamp;
  int likes;

  Post(
      {this.id = "",
      required this.title,
      this.imageUrl = '',
      required this.authorId,
      required this.timestamp,
      this.likes = 0});

  factory Post.fromDoc(DocumentSnapshot doc) {
    return Post(
      id: doc.id,
      title: doc['title'],
      imageUrl: doc['imageUrl'],
      authorId: doc['authorId'],
      timestamp: doc['timestamp'],
      likes: doc['likes'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'authorId': authorId,
      'timestamp': timestamp,
      'likes': likes,
    };
  }
}
