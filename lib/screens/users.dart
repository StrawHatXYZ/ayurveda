import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

import 'chat.dart';
import 'util.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  bool _isLoading = false;

  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: Colors.white,
          title: const Text('Users'),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              FeatherIcons.chevronLeft,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: StreamBuilder<List<types.User>>(
          stream: FirebaseChatCore.instance.users(),
          initialData: const [],
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                  bottom: 200,
                ),
                child: const Text('No users'),
              );
            }

            return _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final user = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          _handlePressed(user, context);
                          setState(() {
                            //set circular progress indicator
                            _isLoading = true;
                          });
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          //onhover change color
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 0.4,
                              ),
                            ),
                          ),
                          margin: EdgeInsets.only(
                            bottom: index == snapshot.data!.length - 1 ? 16 : 0,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          child: Row(
                            children: [
                              _buildAvatar(user),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(getUserName(user),
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.black87)),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      );

  Widget _buildAvatar(types.User user) {
    const color = Color.fromARGB(255, 194, 243, 255);
    final name = getUserName(user);

    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundColor: color,
        backgroundImage: null,
        radius: 20,
        child: Text(
          name.isEmpty ? '' : name[0].toUpperCase() + name[1].toUpperCase(),
          style: const TextStyle(color: Colors.cyan),
        ),
      ),
    );
  }

  void _handlePressed(types.User otherUser, BuildContext context) async {
    final navigator = Navigator.of(context);
    final room = await FirebaseChatCore.instance.createRoom(otherUser);

    // navigator.pop();

    await navigator.push(
      MaterialPageRoute(
        builder: (context) => ChatPage(
          room: room,
        ),
      ),
    );
    setState(() {
      //set circular progress indicator
      _isLoading = false;
    });
  }
}
