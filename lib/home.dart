import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health/widgets/appbar.dart';
import 'package:health/constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var selectedPageIndex = 0;

  List<String> pages = ["Home", "Chat", "Favorite", "Cart"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 121, 42, 134),
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
              iconColor: Colors.white,
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
          selectedPageIndex == 0
              ? Appbar(
                  context: context,
                )
              : const Text(""),
          Expanded(
            child: Center(
              child: Text(pages[selectedPageIndex],
                  style: const TextStyle(fontSize: 32)),
            ),
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
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
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
          label: 'chat',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.favorite),
          icon: Icon(Icons.favorite_border),
          label: 'favorite',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.shopping_cart),
          icon: Icon(Icons.shopping_cart_outlined),
          label: 'favorite',
        ),
      ],
    );
  }
}
