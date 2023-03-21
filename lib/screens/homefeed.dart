import 'package:flutter/material.dart';

class Post {
  final String username;
  final String handle;
  final String content;
  final String imageUrl;

  Post(
      {required this.username,
      required this.handle,
      required this.content,
      this.imageUrl = ''});
}

class HomeFeed extends StatelessWidget {
  final List<Post> posts = [
    Post(
      username: 'John Smith',
      handle: '@johnsmith',
      content: 'This is my first post!',
    ),
    Post(
      username: 'Jane Doe',
      handle: '@janedoe',
      content: 'Hello world!',
      imageUrl: 'https://picsum.photos/200/300',
    ),
    Post(
      username: 'Bob Johnson',
      handle: '@bobjohnson',
      content: 'Flutter is awesome!',
    ),
  ];

  HomeFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                            'https://picsum.photos/seed/${post.username}/40'),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post.username),
                          Text(post.handle,
                              style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(post.content),
                  if (post.imageUrl.isNotEmpty)
                    SizedBox(
                      height: 200,
                      child: Image.network(post.imageUrl, fit: BoxFit.cover),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
