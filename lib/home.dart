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
      'icon': FeatherIcons.fileText,
      'page': const Protocols(),
      'index': 2,
    },
    {
      'title': 'Shopping',
      'icon': FeatherIcons.shoppingCart,
      'page': ShoppingScreen(),
      'index': 3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    var scaffoldkey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldkey,
      //white appbar with searchbar menu and profile
      appBar: _page == 0 || _page == 3
          ? AppBar(
              leading: IconButton(
                icon: const Icon(FeatherIcons.menu),
                color: Colors.black,
                onPressed: () {
                  scaffoldkey.currentState!.openDrawer();
                },
              ),
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
      floatingActionButton: _page == 0
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: const Icon(Icons.add_outlined, color: Colors.white),
              onPressed: () {},
            )
          : null,
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
              Padding(
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
