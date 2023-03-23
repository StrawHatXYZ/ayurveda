import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'chat.dart';
import 'util.dart';
import 'users.dart';

class RoomsPage extends StatefulWidget {
  const RoomsPage({super.key});

  @override
  State<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  User? _user;

  @override
  void initState() {
    super.initState();

    _user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        // systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.white,
        title: const Text('Chats',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
        automaticallyImplyLeading: false,
      ),
      body: _user == null
          ? Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                bottom: 200,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Not authenticated'),
                ],
              ),
            )
          : StreamBuilder<List<types.Room>>(
              stream: FirebaseChatCore.instance.rooms(),
              initialData: const [],
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(
                      bottom: 200,
                    ),
                    child: const Text('No Chats'),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final room = snapshot.data![index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChatPage(
                              room: room,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          top: index == 0 ? 10 : 0,
                          bottom: index == snapshot.data!.length - 1 ? 10 : 0,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        //onhover change color
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black38,
                              width: 0.2,
                            ),
                          ),
                        ),
                        //Row with avatar, name, last message and time
                        child: Row(
                          children: [
                            _buildAvatar(room),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  //Capitalise first letter of name
                                  room.name!.substring(0, 1).toUpperCase() +
                                      room.name!.substring(1),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87),
                                ),
                                Text("Last message",
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black54)),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  //convert timestamp to time
                                  convertTimestampToTime(room.updatedAt!),
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black54),
                                ),
                                //randomly assign unread messages
                                (room.updatedAt! % 2) == 0
                                    ? Container(
                                        margin: const EdgeInsets.only(top: 4),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.cyan,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          "1",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: _user == null
            ? null
            : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UsersPage(),
                  ),
                );
              },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

//convert timestamp to time function
  String convertTimestampToTime(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var now = DateTime.now();
    var difference = now.difference(date);
    var time = '';

    if (difference.inDays > 7) {
      time = '${date.day}/${date.month}/${date.year}';
    } else if (difference.inDays > 1) {
      time = '${difference.inDays} days ago';
    } else if (difference.inDays == 1) {
      time = 'Yesterday';
    } else if (difference.inHours > 1) {
      time = '${difference.inHours} hours ago';
    } else if (difference.inHours == 1) {
      time = '1 hour ago';
    } else if (difference.inMinutes > 1) {
      time = '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes == 1) {
      time = '1 minute ago';
    } else if (difference.inSeconds > 1) {
      time = '${difference.inSeconds} seconds ago';
    } else if (difference.inSeconds == 1) {
      time = '1 second ago';
    } else {
      time = 'Just now';
    }

    return time;
  }

//avatar with active status`
  Widget _buildAvatar(types.Room room) {
    var color = Color.fromARGB(171, 194, 243, 255);

    if (room.type == types.RoomType.direct) {
      try {
        final otherUser = room.users.firstWhere(
          (u) => u.id != _user!.uid,
        );

        color = color;
      } catch (e) {
        // Do nothing if other user is not found.
      }
    }

    final hasImage = room.imageUrl != null;
    final name = room.name ?? '';

    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Stack(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                name.substring(0, 2).toUpperCase(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.cyan,
                ),
              ),
            ),
          ),
          //randomly assign active status
          (room.updatedAt! % 2) == 0
              ? Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(7.5),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
