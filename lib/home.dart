import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health/constants.dart';
import 'package:health/screens/chatmessages.dart';
import 'package:health/screens/homefeed.dart';
import 'package:health/screens/profile.dart';
import 'package:health/screens/shopping.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _page = 0;

  //Pages widget
  List pages = [
    {
      'title': 'Home',
      'icon': Icons.home_outlined,
      'page': HomeFeed(),
      'index': 0,
    },
    {
      'title': 'Messages',
      'icon': Icons.messenger_outline,
      'page': const RoomsPage(),
      'index': 1,
    },
    {
      'title': 'unsee',
      'icon': Icons.visibility_off_outlined,
      'page': const Text('nes'),
      'index': 2,
    },
    {
      'title': 'Protocols',
      'icon': Icons.book_outlined,
      'page': const Text('Protocols'),
      'index': 3,
    },
    {
      'title': 'Shopping',
      'icon': Icons.shopping_cart_outlined,
      'page': ShoppingScreen(),
      'index': 4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //white appbar with searchbar menu and profile
      appBar: _page == 0 || _page == 4
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
                  icon: const Icon(Icons.person),
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

      body: PageTransitionSwitcher(
        transitionBuilder: (
          Widget child,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return SharedAxisTransition(
            transitionType: SharedAxisTransitionType.horizontal,
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: pages[_page]['page'],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        elevation: 0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 5),
            for (Map item in pages)
              item['index'] == 2
                  ? buildFab()
                  : Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: IconButton(
                        icon: Icon(
                          item['icon'],
                          color: item['index'] != _page
                              ? Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black
                              : Theme.of(context).colorScheme.secondary,
                          size: 25.0,
                        ),
                        onPressed: () => navigationTapped(item['index']),
                      ),
                    ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }

  buildFab() {
    return SizedBox(
        height: 45.0,
        width: 45.0,
        // ignore: missing_required_param
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add_outlined,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () {},
        ));
  }

  void navigationTapped(int page) {
    setState(() {
      _page = page;
    });
  }
}
