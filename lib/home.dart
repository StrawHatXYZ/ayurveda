import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ayurveda/constants.dart';
import 'package:ayurveda/screens/add_post.dart';
import 'package:ayurveda/screens/chatmessages.dart';
import 'package:ayurveda/screens/homefeed.dart';
import 'package:ayurveda/screens/profile.dart';
import 'package:ayurveda/screens/protocols.dart';
import 'package:ayurveda/screens/shopping.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ayurveda/models/user_model.dart' as user_model;
import 'package:ayurveda/searchscreen.dart';
import 'package:ayurveda/util.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _page = 0;
  user_model.User? _user;
  @override
  void initState() {
    Util().getUser().then((value) => setState(() {
          _user = value;
        }));
    super.initState();
  }

  void onTabTapped(int index) {
    setState(() {
      _page = index;
    });
  }

  //Pages widget
  late List pages = [
    {
      'title': 'Home',
      'icon': FeatherIcons.home,
      'page': const TimelineView(),
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
      'page': ShoppingScreen(),
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
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  width: Constants(context).width * 0.75,
                  height: Constants(context).height * 0.45,
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
                      //Searchbar onclick open search page
                      Expanded(
                        child: TextField(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SearchScreen()),
                            );
                          },
                          //Ontap outside remove focus
                          onTapOutside: (value) {
                            FocusScope.of(context).unfocus();
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search',
                          ),
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
                          builder: (context) => UserProfileScreen(
                                user: _user,
                              )),
                    );
                  },
                ),
              ],
            )
          : null,
      //Drawer user profile pic and name
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.cyan,
                    ),
                    child: Row(
                      children: [
                        //rounded border profile pic
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              //Get user profile pic
                              _user?.imageUrl ?? "assets/images/user.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                //Authenticated User name
                                //Get username fullname _user.name
                                _user?.fullName ?? "User Name",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                _user?.email ?? "User Email",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    iconColor: Colors.black,
                    textColor: Colors.black,
                    leading: const Icon(FeatherIcons.messageSquare),
                    title: const Text('Messages'),
                    onTap: () => {
                      setState(() {
                        _page = 1;
                        Navigator.pop(context);
                      }),
                    },
                  ),
                  ListTile(
                    iconColor: Colors.black,
                    textColor: Colors.black,
                    leading: const Icon(FeatherIcons.user),
                    title: const Text('Profile'),
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserProfileScreen(
                                  user: _user,
                                )),
                      ),
                    },
                  ),
                  ListTile(
                    iconColor: Colors.black,
                    textColor: Colors.black,
                    leading: const Icon(FeatherIcons.book),
                    title: const Text('Protocols'),
                    onTap: () => {
                      setState(() {
                        _page = 2;
                        Navigator.pop(context);
                      }),
                    },
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
          ],
        ),
      ),

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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreatePostScreen()),
                );
              },
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
