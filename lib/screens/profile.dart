import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
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
            height: 200.0,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.cyan],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/images/user.jpg'),
                ),
                SizedBox(height: 10.0),
                Text(
                  'George Silva',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  const ListTile(
                    title: Text('Email'),
                    subtitle: Text('george.silva@example.com'),
                    leading: Icon(Icons.email),
                  ),
                  const Divider(),
                  const ListTile(
                    title: Text('Phone'),
                    subtitle: Text('+(902) 936-6880'),
                    leading: Icon(Icons.phone),
                  ),
                  const Divider(),
                  const ListTile(
                    title: Text('Address'),
                    subtitle: Text('9538 E Sandy Lake Rd'),
                    leading: Icon(Icons.home),
                  ),
                  const Divider(),
                  const ListTile(
                    title: Text('Website'),
                    subtitle: Text('johndoe.com'),
                    leading: Icon(Icons.link),
                  ),
                  const Divider(),
                  //Sign out lsit tile
                  ListTile(
                    iconColor: Colors.black,
                    textColor: Colors.black,
                    leading: const Icon(Icons.exit_to_app),
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
