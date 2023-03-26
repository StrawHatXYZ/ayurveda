import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override

  //Searchscreen with searchbar and list of users
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(8.0),
                            border: InputBorder.none,
                            hintText: 'Search for something..',
                            hintStyle: TextStyle(color: Colors.grey[600]),
                          ),
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          onSubmitted: (value) {},
                          autofocus: true,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: const Center(
              child: Text(
                "No Results",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
