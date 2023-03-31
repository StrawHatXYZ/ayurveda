import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ayurveda/models/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ayurveda/screens/post_view.dart';
import 'package:ayurveda/screens/users.dart';

class TimelineView extends StatefulWidget {
  const TimelineView({Key? key}) : super(key: key);

  @override
  State<TimelineView> createState() => _TimelineViewState();
}

class _TimelineViewState extends State<TimelineView> {
  final Stream<QuerySnapshot> _postsStream = FirebaseFirestore.instance
      .collection('posts')
      .orderBy('timestamp', descending: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        //check if _poststeam length is 0
//Sort by timestamp
        body: StreamBuilder<QuerySnapshot>(
            stream: _postsStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Text(
                    "Loading...",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
              return ListView(
                children: snapshot.data!.docs.map((
                  DocumentSnapshot element,
                ) {
                  Post post = Post.fromDoc(element);
                  return TimelineTile(
                    title: post.name,
                    subtitle: post.title,
                    time: post.timestamp,
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
  final Timestamp time;
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
                  radius: 24,
                  backgroundImage: NetworkImage(
                    userImage,
                  )),
              title: Text(title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w600)),
              subtitle: Text(timeAgoFromTimestamp(time),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey)),
              trailing: IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.more_horiz,
                    color: Theme.of(context).iconTheme.color,
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PostView(
                          post_title: subtitle,
                          post_url: postImage,
                          user_name: title,
                          user_image: userImage,
                          time: timeAgoFromTimestamp(time))),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  subtitle.isEmpty
                      ? const SizedBox.shrink()
                      : Text(
                          subtitle,
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black87),
                        ),
                  const SizedBox(height: 10),
                  postImage.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: postImage.isNotEmpty
                              ? Image.network(
                                  postImage,
                                  fit: BoxFit.cover,
                                  height: 300,
                                  width: double.infinity,
                                )
                              : CircularProgressIndicator(),
                        )
                      : const Text(''),
                ],
              ),
            ),
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

  String timeAgoFromTimestamp(Timestamp timestamp) {
    final now = DateTime.now().toUtc();
    final date = timestamp.toDate().toUtc();

    final difference = now.difference(date);

    if (difference.inDays >= 365) {
      final years = (difference.inDays / 365).floor();
      return '$years year${years == 1 ? '' : 's'} ago';
    } else if (difference.inDays >= 30) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months == 1 ? '' : 's'} ago';
    } else if (difference.inDays >= 7) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks week${weeks == 1 ? '' : 's'} ago';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }
}
