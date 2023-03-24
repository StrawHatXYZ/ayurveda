import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health/constants.dart';
import 'package:health/screens/chatmessages.dart';
import 'package:health/screens/homefeed.dart';
import 'package:health/screens/profile.dart';
import 'package:health/screens/protocols.dart';
import 'package:health/screens/shopping.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _page = 0;
  void onTabTapped(int index) {
    setState(() {
      _page = index;
    });
  }

  //Pages widget
  List pages = [
    {
      'title': 'Home',
      'icon': FeatherIcons.home,
      'page': TimelineView(),
      'index': 0,
    },
    {
      'title': 'Messages',
      'icon': FeatherIcons.messageSquare,
      'page': const RoomsPage(),
      'index': 1,
    },
    {
      'title': 'Protocols',
      'icon': FeatherIcons.book,
      'page': const Protocols(),
      'index': 2,
    },
    {
      'title': 'Shopping',
      'icon': FeatherIcons.shoppingCart,
      'page': const ShoppingScreen(),
      'index': 3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //white appbar with searchbar menu and profile
      appBar: _page == 0 || _page == 3
          ? AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              actions: [
                Container(
                  width: Constants(context).width * 0.75,
                  height: Constants(context).height * 0.05,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.search),
                        color: Colors.black,
                        onPressed: () {},
                      ),
                      const Center(
                        child: Text(
                          'Search for something',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(FeatherIcons.user),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserProfileScreen()),
                    );
                  },
                ),
              ],
            )
          : null,
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.cyan,
              ),
              child: Text(
                'Drawer ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            const ListTile(
              iconColor: Colors.black,
              textColor: Colors.black,
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            const ListTile(
              iconColor: Colors.black,
              textColor: Colors.black,
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            const ListTile(
              iconColor: Colors.black,
              textColor: Colors.black,
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
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
      //open drawer

      body: IndexedStack(
        /// Replaced with IndexedStack
        index: _page,
        children: [
          for (Map item in pages) item['page'],
        ],
      ),
      floatingActionButton: _page == 0
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: const Icon(Icons.add_outlined, color: Colors.white),
              onPressed: () {},
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        elevation: 0,
        backgroundColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          for (Map item in pages)
            BottomNavigationBarItem(
              icon: Icon(item['icon']),
              label: item['title'],
            ),
        ],
      ),
    );
  }
}
