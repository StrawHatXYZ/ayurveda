// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  String title;
  String imageUrl;
  String authorId;
  String name;
  String profileUrl;

  Timestamp timestamp;
  int likes;

  Post(
      {this.id = "",
      required this.title,
      this.imageUrl = '',
      required this.authorId,
      required this.timestamp,
      required this.name,
      this.profileUrl = "",
      this.likes = 0});

  factory Post.fromDoc(DocumentSnapshot doc) {
    return Post(
      id: doc.id,
      profileUrl: doc['profileUrl'],
      name: doc['name'],
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
      'name': name,
      'profileUrl': profileUrl,
      'imageUrl': imageUrl,
      'authorId': authorId,
      'timestamp': timestamp,
      'likes': likes,
    };
  }
}
