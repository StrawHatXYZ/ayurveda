import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:firebase_auth/firebase_auth.dart';

const colors = [
  Color(0xffff6767),
  Color(0xff66e0da),
  Color(0xfff5a2d9),
  Color(0xfff0c722),
  Color(0xff6a85e5),
  Color(0xfffd9a6f),
  Color(0xff92db6e),
  Color(0xff73b8e5),
  Color(0xfffd7590),
  Color(0xffc78ae5),
];

Color getUserAvatarNameColor(types.User user) {
  final index = user.id.hashCode % colors.length;
  return colors[index];
}

//capitalize first letter of name
String getUserName(types.User user) {
  return user.firstName!.substring(0, 1).toUpperCase() +
      user.firstName!.substring(1);
}

//Import email from firebase auth
String getUserEmail(types.User user) {
  return FirebaseAuth.instance.currentUser!.email!;
}
