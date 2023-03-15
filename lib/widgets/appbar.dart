import 'package:flutter/material.dart';
import 'package:health/constants.dart';

class Appbar extends StatefulWidget {
  final BuildContext context;
  const Appbar({
    super.key,
    required this.context,
  });

  @override
  State<Appbar> createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  final node = FocusNode();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconButton(
          icon: Icon(Icons.menu,
              color: Colors.black, size: Constants(context).width * 0.07),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        Container(
          width: Constants(context).width * 0.7,
          height: Constants(context).height * 0.06,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: TextField(
              onTapOutside: (event) {
                node.unfocus();
              },
              focusNode: node,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search for something',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.account_circle_rounded,
              color: Colors.black, size: Constants(context).width * 0.09),
          onPressed: () {},
        ),
      ]),
    );
  }
}
