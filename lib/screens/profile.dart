import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ayurveda/constants.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ayurveda/models/user_model.dart' as user_model;
import 'package:ayurveda/util.dart';

class UserProfileScreen extends StatefulWidget {
  user_model.User? user;

  UserProfileScreen({super.key, required this.user});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    user_model.User? user = widget.user;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('User Profile'),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            FeatherIcons.chevronLeft,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: Constants(context).height * 0.25,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.cyan],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 80,
                  width: 80,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(user?.imageUrl ?? "No image"),
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  user?.fullName ?? "No name",
                  style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5.0),
                const Text(
                  'Flutter Developer',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(Constants(context).height * 0.01),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: const Text('Email'),
                    subtitle: Text(user?.email ?? "No email"),
                    leading: const Icon(FeatherIcons.mail),
                  ),
                  const Divider(),
                  const ListTile(
                    title: Text('Phone'),
                    subtitle: Text('+(902) 936-6880'),
                    leading: Icon(FeatherIcons.phone),
                  ),
                  const Divider(),
                  const ListTile(
                    title: Text('Address'),
                    subtitle: Text('9538 E Sandy Lake Rd'),
                    leading: Icon(FeatherIcons.home),
                  ),
                  const Divider(),
                  const ListTile(
                    title: Text('Website'),
                    subtitle: Text('johndoe.com'),
                    leading: Icon(FeatherIcons.link),
                  ),
                  const Divider(),
                  //Sign out lsit tile
                  ListTile(
                    iconColor: Colors.black,
                    textColor: Colors.black,
                    leading: const Icon(Icons.logout),
                    title: const Text('Signout'),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
