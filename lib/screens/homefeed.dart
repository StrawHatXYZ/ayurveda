import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:health/models/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TimelineView extends StatefulWidget {
  const TimelineView({Key? key}) : super(key: key);

  @override
  State<TimelineView> createState() => _TimelineViewState();
}

class _TimelineViewState extends State<TimelineView> {
  final Stream<QuerySnapshot> _postsStream =
      FirebaseFirestore.instance.collection('posts').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder<QuerySnapshot>(
            stream: _postsStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }
              return ListView(
                children: snapshot.data!.docs.map((
                  element,
                ) {
                  Post post = Post.fromDoc(element);
                  return TimelineTile(
                    title: post.name,
                    subtitle: post.title,
                    time:
                        "${post.timestamp.toDate().day}/${post.timestamp.toDate().month}/${post.timestamp.toDate().year}",
                    userImage: post.profileUrl,
                    postImage: post.imageUrl,
                  );
                }).toList(),
              );
            }));
  }
}

class TimelineTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final String userImage;
  final String postImage;

  const TimelineTile(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.time,
      required this.userImage,
      required this.postImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.only(left: 16, right: 16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    userImage,
                  )),
              title: Text(title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 18, fontWeight: FontWeight.w600)),
              subtitle: Text(time,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey)),
              trailing: IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.more_horiz,
                    color: Theme.of(context).iconTheme.color,
                  )),
            ),
            subtitle.isEmpty
                ? const SizedBox.shrink()
                : Text(
                    subtitle,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87),
                  ),
            const SizedBox(height: 10),
            postImage.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      postImage,
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Text(''),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: null,
                        icon: Icon(FeatherIcons.heart,
                            color: Theme.of(context).iconTheme.color)),
                    IconButton(
                        onPressed: null,
                        icon: Icon(FeatherIcons.messageCircle,
                            color: Theme.of(context).iconTheme.color)),
                    IconButton(
                        onPressed: null,
                        icon: Icon(FeatherIcons.share,
                            color: Theme.of(context).iconTheme.color))
                  ],
                ),
                IconButton(
                    onPressed: null,
                    icon: Icon(
                      FeatherIcons.bookmark,
                      color: Theme.of(context).iconTheme.color,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
