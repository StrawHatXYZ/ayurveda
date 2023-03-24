import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class TimelineView extends StatelessWidget {
  TimelineView({Key? key}) : super(key: key);
//Sample data for timeline
  final List<Map<String, dynamic>> _timelineData = [
    {
      'title': 'John Doe',
      'subtitle': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'time': '2 hours ago',
      'image': 'https://picsum.photos/210/300',
    },
    {
      'title': 'John Doe',
      'subtitle': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'time': '2 hours ago',
      'image': 'https://picsum.photos/200/300',
    },
    {
      'title': 'John Doe',
      'subtitle': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'time': '2 hours ago',
      'image': 'https://picsum.photos/200/300',
    },
    {
      'title': 'John Doe',
      'subtitle': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'time': '2 hours ago',
      'image': 'https://picsum.photos/200/300',
    },
    {
      'title': 'John Doe',
      'subtitle': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'time': '2 hours ago',
      'image': 'https://picsum.photos/200/300',
    },
    {
      'title': 'John Doe',
      'subtitle': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'time': '2 hours ago',
      'image': 'https://picsum.photos/200/300',
    },
    {
      'title': 'John Doe',
      'subtitle': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'time': '2 hours ago',
      'image': 'https://picsum.photos/200/300',
    },
    {
      'title': 'John Doe',
      'subtitle': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'time': '2 hours ago',
      'image': 'https://picsum.photos/200/300',
    },
    {
      'title': 'John Doe',
      'subtitle': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'time': '2 hours ago',
      'image': 'https://picsum.photos/200/300',
    },
    {
      'title': 'John Doe',
      'subtitle': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'time': '2 hours ago',
      'image': 'https://picsum.photos/200/300',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          for (var i = 0; i < _timelineData.length; i++)
            TimelineTile(
              title: _timelineData[i]['title'],
              subtitle: _timelineData[i]['subtitle'],
              time: _timelineData[i]['time'],
              image: _timelineData[i]['image'],
            ),
        ],
      ),
    );
  }
}

//TImeline tile function
/* return Card(
                    elevation: 0,
                    color: Theme.of(context).cardColor,
                    margin: const EdgeInsets.all(16),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StreamBuilder<Map<String, dynamic>?>(
                              stream: _postManager
                                  .getUserInfo(snapshot.data!.docs[index]
                                      .data()!['user_uid'])
                                  .asStream(),
                              builder: (context, userSnapshot) {
                                if (userSnapshot.connectionState ==
                                        ConnectionState.waiting &&
                                    userSnapshot.data == null) {
                                  return const Center(
                                      child:
                                          LinearProgressIndicator());
                                }

                                if (userSnapshot.connectionState ==
                                        ConnectionState.done &&
                                    userSnapshot.data == null) {
                                  return const ListTile();
                                }
                                return ListTile(
                                  contentPadding: const EdgeInsets.all(0),
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                        userSnapshot.data!['picture']!),
                                  ),
                                  title: Text(userSnapshot.data!['name'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
                                  subtitle: Text(
                                      timeago.format(
                                          snapshot.data!.docs[index]
                                              .data()!['createdAt']
                                              .toDate(),
                                          allowFromNow: true),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                  trailing: IconButton(
                                      onPressed: null,
                                      icon: Icon(
                                        Icons.more_horiz,
                                        color:
                                            Theme.of(context).iconTheme.color,
                                      )),
                                );
                              }),
                          snapshot.data!.docs[index]
                                  .data()!['description']!
                                  .isEmpty
                              ? const SizedBox.shrink()
                              : Text(
                                  snapshot.data!.docs[index]
                                      .data()!['description']!,
                                  textAlign: TextAlign.left,
                                ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              snapshot.data!.docs[index].data()!['image_url']!,
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: null,
                                      icon: Icon(UniconsLine.thumbs_up,
                                          color: Theme.of(context)
                                              .iconTheme
                                              .color)),
                                  IconButton(
                                      onPressed: null,
                                      icon: Icon(UniconsLine.comment_lines,
                                          color: Theme.of(context)
                                              .iconTheme
                                              .color))
                                ],
                              ),
                              IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    UniconsLine.telegram_alt,
                                    color: Theme.of(context).iconTheme.color,
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                  */

//Timeline tile function based  on above code
class TimelineTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final String image;

  const TimelineTile(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.time,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(image),
              ),
              title: Text(title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 18, fontWeight: FontWeight.w600)),
              subtitle: Text(time,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
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
                  ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                image,
                height: 200,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: null,
                        icon: Icon(FeatherIcons.heart),
                        color: Theme.of(context).iconTheme.color),
                    IconButton(
                        onPressed: null,
                        icon: Icon(FeatherIcons.messageCircle,
                            color: Theme.of(context).iconTheme.color))
                  ],
                ),
                IconButton(
                    onPressed: null,
                    icon: Icon(
                      FeatherIcons.share,
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
