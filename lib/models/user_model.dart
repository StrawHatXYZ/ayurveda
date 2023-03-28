import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String fullName;
  final String email;
  final String address;
  final String phone;
  final String website;
  final String imageUrl;
  final String bio;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.address,
    required this.phone,
    this.website = "",
    this.imageUrl = "",
    this.bio = "",
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      fullName: map['fullName'],
      email: map['email'],
      address: map['address'],
      phone: map['phone'],
      website: map['website'] ?? "",
      imageUrl: map['imageUrl'] ?? "",
      bio: map['bio'] ?? "",
    );
  }

  factory User.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    return User(
      id: doc.id,
      fullName: doc['fullName'],
      email: doc['email'],
      address: doc['address'],
      phone: doc['phone'],
      website: doc['website'] ?? "",
      imageUrl: doc['imageUrl'] ?? "",
      bio: doc['bio'] ?? "",
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'address': address,
      'phone': phone,
      'website': website,
      'imageUrl': imageUrl,
      'bio': bio,
    };
  }
}
