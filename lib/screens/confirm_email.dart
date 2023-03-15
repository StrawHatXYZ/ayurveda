import 'package:flutter/material.dart';

class ConfirmEmail extends StatelessWidget {
  static String id = 'confirm-email';
  final String message;

  const ConfirmEmail({required Key key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          message,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
      )),
    );
  }
}
