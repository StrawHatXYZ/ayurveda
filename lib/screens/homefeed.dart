import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class TimelineView extends StatelessWidget {
  TimelineView({Key? key}) : super(key: key);
//Sample data for timeline
  final List<Map<String, dynamic>> _timelineData = [
    {
      'title': 'Khalid',
      'subtitle':
          'Kudo millet is a good source of protein. It is also rich in fiber, vitamins, and minerals. ',
      'time': '12 mins ago',
      //random person image
      'user_image': 'https://randomuser.me/api/portraits/men/9.jpg',
      //random post image
      'post_image':
          'https://thumbs.dreamstime.com/b/bajra-pearl-millet-glass-bowl-205225996.jpg',
    },
    {
      'title': 'Aryan',
      'subtitle':
          'Bajra Pearl Millet is a good source of protein. It is also rich in fiber, vitamins, and minerals. ',
      'time': '2 hours ago',
      'user_image': 'https://randomuser.me/api/portraits/men/76.jpg',
      'post_image':
          'https://thumbs.dreamstime.com/b/kodo-millet-brown-color-paspalum-scrobiculatum-169401257.jpg',
    },
    {
      'title': 'Sara',
      'subtitle':
          'Ragi is a good source of protein. It is also rich in fiber, vitamins, and minerals. ',
      'time': '2 hours ago',
      'user_image': 'https://randomuser.me/api/portraits/women/56.jpg',
      'post_image':
          'https://thumbs.dreamstime.com/b/ragi-finger-millet-balls-which-healthy-southern-indian-food-white-ceramic-plate-ragi-finger-millet-balls-stack-115647584.jpg',
    },
    {
      'title': 'Tina',
      'subtitle': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'time': '2 hours ago',
      'user_image': 'https://randomuser.me/api/portraits/women/11.jpg',
      'post_image': 'https://picsum.photos/200/300',
    },
    {
      'title': 'Kristina',
      'subtitle': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'time': '2 hours ago',
      'user_image': 'https://randomuser.me/api/portraits/women/11.jpg',
      'post_image': 'https://picsum.photos/200/300',
    },
    {
      'title': 'Leonardo',
      'subtitle': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'time': '2 hours ago',
      'user_image': 'https://randomuser.me/api/portraits/men/22.jpg',
      'post_image': 'https://picsum.photos/200/300',
    }
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
              user_image: _timelineData[i]['user_image'],
              post_image: _timelineData[i]['post_image'],
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
  final String user_image;
  final String post_image;

  const TimelineTile(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.time,
      required this.user_image,
      required this.post_image})
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
                backgroundImage: NetworkImage(user_image),
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
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87),
                  ),
            SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                post_image,
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
