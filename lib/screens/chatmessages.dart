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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'John',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.keyboard_backspace),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = messages[index];
                return Align(
                  alignment: message.isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
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
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomAppBar(
              elevation: 0.0,
              child: Container(
                //add border
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey[200]!,
                      width: 1.5,
                    ),
                  ),
                ),
                constraints: BoxConstraints(maxHeight: 100.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.photo_camera,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      onPressed: () => {},
                    ),
                    Flexible(
                      child: TextField(
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Theme.of(context).textTheme.headline6!.color,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          hintText: "Type your message",
                          hintStyle: TextStyle(
                            color: Theme.of(context).textTheme.headline6!.color,
                          ),
                        ),
                        maxLines: null,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final bool isMe;

  Message({required this.text, required this.isMe});
}
