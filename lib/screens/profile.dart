import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health/constants.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:health/models/user_model.dart ' as user_model;
import 'package:health/util.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  user_model.User? _user;

  @override
  void initState() {
    Util().getUser().then((value) => setState(() {
          _user = value;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('User Profile'),
        elevation: 0,
        backgroundColor: Colors.white,
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
                const CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/images/user.jpg'),
                ),
                const SizedBox(height: 10.0),
                Text(
                  "${_user?.fullName.substring(0, 1).toUpperCase()}${_user?.fullName.substring(1)}",
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
