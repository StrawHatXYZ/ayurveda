import 'package:flutter/material.dart';

class ChatMessagesScreen extends StatelessWidget {
  final List<Message> messages = [
    Message(text: 'Hi', isMe: true),
    Message(text: 'Hello', isMe: false),
    Message(text: 'How are you?', isMe: true),
    Message(text: 'I am good. How about you?', isMe: false),
    Message(text: 'I am doing great!', isMe: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Messages'),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int index) {
          final message = messages[index];
          return Align(
            alignment:
                message.isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                color: message.isMe ? Colors.cyan[600] : Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                    color: message.isMe ? Colors.white : Colors.black),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Message {
  final String text;
  final bool isMe;

  Message({required this.text, required this.isMe});
}
