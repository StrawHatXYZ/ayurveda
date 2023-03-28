//User Model
// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String username;
  final String fullname;
  final String email;
  final String address;
  final String phone;
  final String website;
  final String imageUrl;
  final String bio;
  final Timestamp timestamp;

  User({
    required this.id,
    required this.username,
    required this.fullname,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.imageUrl,
    required this.bio,
    required this.timestamp,
  });

  factory User.fromDoc(DocumentSnapshot doc) {
    return User(
      id: doc.id,
      username: doc['username'],
      fullname: doc['fullname'],
      email: doc['email'],
      address: doc['address'],
      phone: doc['phone'],
      website: doc['website'],
      imageUrl: doc['imageUrl'],
      bio: doc['bio'],
      timestamp: doc['timestamp'],
    );
  }
}
