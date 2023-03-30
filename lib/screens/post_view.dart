import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

//POSTVIEW CLASS WITH POST AS PARAMETER AND STATEFUL WIDGET, DISPLAYS POST IMAGE AND POST TITLE
class PostView extends StatefulWidget {
  final String post_url;
  final String post_title;
  final String user_name;
  final String user_image;
  final String time;

  const PostView(
      {Key? key,
      required this.post_url,
      required this.post_title,
      required this.user_name,
      required this.user_image,
      required this.time})
      : super(key: key);

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Post"),
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(
              FeatherIcons.chevronLeft,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                FeatherIcons.moreHorizontal,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: ListView(
          children: [
            //POST IMAGE
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.post_url), fit: BoxFit.fill),
              ),
            ),
            //POST TITLE

            ///User Details
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
              child: Row(
                children: [
                  //USER IMAGE
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(widget.user_image),
                  ),
                  const SizedBox(width: 10.0),
                  //USER NAME
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.user_name,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.time,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                widget.post_title,
                style: const TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            //like comment share buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          FeatherIcons.heart,
                          color: Colors.black,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(
                          FeatherIcons.messageCircle,
                          color: Colors.black,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(
                          FeatherIcons.send,
                          color: Colors.black,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      FeatherIcons.bookmark,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
