import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health/constants.dart';
import 'package:health/screens/homefeed.dart';
import 'package:health/screens/messages.dart';
import 'package:health/screens/profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var selectedPageIndex = 0;

  //Pages widget
  final List<Widget> _pages = [
    HomeFeed(),
    MessagesScreen(),
    const Center(
      child: Text('Page 3'),
    ),
    const Center(
      child: Text('Page 4'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //white appbar with searchbar menu and profile
      appBar: selectedPageIndex == 0
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
                  height: Constants(context).height * 0.058,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
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
                  icon: const Icon(Icons.person),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserProfileScreen()),
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

      body: Column(
        children: [
          Expanded(
            child: _pages[selectedPageIndex],
          ),
        ],
      ),
      bottomNavigationBar: bottomNavigation(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  NavigationBar bottomNavigation(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedPageIndex,
      height: Constants(context).height * 0.08,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      onDestinationSelected: (int index) {
        setState(() {
          selectedPageIndex = index;
        });
      },
      destinations: const <NavigationDestination>[
        NavigationDestination(
          selectedIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.chat_bubble),
          icon: Icon(Icons.chat_bubble_outline),
          label: 'Messages',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.favorite),
          icon: Icon(Icons.favorite_border),
          label: 'Protocols',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.shopping_cart),
          icon: Icon(Icons.shopping_cart_outlined),
          label: 'Shopping',
        ),
      ],
    );
  }
}
