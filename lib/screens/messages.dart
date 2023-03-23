// import 'package:flutter/material.dart';
// import 'package:health/screens/chatmessages.dart';

// class MessagesScreen extends StatelessWidget {
//   final List<Message> messages = [
//     Message(
//       sender: 'John',
//       text: 'Hi, how are you?',
//       time: DateTime.now(),
//     ),
//     Message(
//       sender: 'Mary',
//       text: 'I am good. How about you?',
//       time: DateTime.now(),
//     ),
//     Message(
//       sender: 'John',
//       text: 'I am doing great!',
//       time: DateTime.now(),
//     ),
//   ];

//   MessagesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Messages'),
//       ),
//       body: ListView.builder(
//         itemCount: messages.length,
//         itemBuilder: (BuildContext context, int index) {
//           final message = messages[index];
//           return ListTile(
//             leading: CircleAvatar(
//               backgroundColor: Colors.cyan[100],
//               child: Text(message.sender.substring(0, 1)),
//             ),
//             title: Text(
//               message.sender,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             subtitle: Text(
//               message.text,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//             trailing: Text(
//               '${message.time.hour}:${message.time.minute}',
//             ),
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                 builder: (_) => ChatMessagesScreen(),
//               ));
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class Message {
//   final String sender;
//   final String text;
//   final DateTime time;

//   Message({required this.sender, required this.text, required this.time});

//   Message.textOnly({required this.text})
//       : sender = 'Unknown',
//         time = DateTime.now();
// }
