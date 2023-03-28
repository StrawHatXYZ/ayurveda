import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:loading_overlay/loading_overlay.dart';
// import 'package:social_media_app/models/user.dart';
// import 'package:social_media_app/utils/firebase.dart';
// import 'package:social_media_app/view_models/auth/posts_view_model.dart';
// import 'package:social_media_app/widgets/indicators.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    currentUserId() {
      return user?.uid;
    }

    // PostsViewModel viewModel = Provider.of<PostsViewModel>(context);
    return WillPopScope(
      onWillPop: () async {
        // await viewModel.resetPost();
        return true;
      },
      child: LoadingOverlay(
        progressIndicator: const CircularProgressIndicator(),
        isLoading: false, // viewModel
        child: Scaffold(
          // key: viewModel.scaffoldKey,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(FeatherIcons.delete),
              onPressed: () {
                // viewModel.resetPost();
                Navigator.pop(context);
              },
            ),
            title: Text('WOOBLE'.toUpperCase()),
            centerTitle: true,
            actions: [
              GestureDetector(
                onTap: () async {
                  // await viewModel.uploadPosts(context);
                  Navigator.pop(context);
                  // viewModel.resetPost();
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Post'.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              )
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            children: [
              const SizedBox(height: 15.0),
              // StreamBuilder(
              //   stream: user?.doc(currentUserId()).snapshots(),
              //   builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              //     if (snapshot.hasData) {
              //       // UserModel user = UserModel.fromJson(
              //       //   snapshot.data!.data() as Map<String, dynamic>,
              //       // );
              //       return ListTile(
              //         leading: CircleAvatar(
              //           radius: 25.0,
              //           backgroundImage: NetworkImage(user?.photoURL!),
              //         ),
              //         title: Text(
              //           user?.displayName!,
              //           style: const TextStyle(fontWeight: FontWeight.bold),
              //         ),
              //         subtitle: Text(
              //           user?.email!,
              //         ),
              //       );
              //     }
              //     return Container();
              //   },
              // ),
              // // InkWell(
              // //   onTap: () => showImageChoices(context, viewModel),
              // //   child: Container(
              // //     width: MediaQuery.of(context).size.width,
              // //     height: MediaQuery.of(context).size.width - 30,
              // //     decoration: BoxDecoration(
              // //       color: Colors.grey[300],
              // //       borderRadius: const BorderRadius.all(
              // //         Radius.circular(5.0),
              // //       ),
              // //       border: Border.all(
              // //         color: Theme.of(context).colorScheme.secondary,
              // //       ),
              // //     ),
              // //     child: viewModel.imgLink != null
              // //         ? CustomImage(
              // //             imageUrl: viewModel.imgLink,
              // //             width: MediaQuery.of(context).size.width,
              // //             height: MediaQuery.of(context).size.width - 30,
              // //             fit: BoxFit.cover,
              // //           )
              // //         : viewModel.mediaUrl == null
              // //             ? Center(
              // //                 child: Text(
              // //                   'Upload a Photo',
              // //                   style: TextStyle(
              // //                     color:
              // //                         Theme.of(context).colorScheme.secondary,
              // //                   ),
              // //                 ),
              // //               )
              // //             : Image.file(
              // //                 viewModel.mediaUrl!,
              // //                 width: MediaQuery.of(context).size.width,
              // //                 height: MediaQuery.of(context).size.width - 30,
              // //                 fit: BoxFit.cover,
              // //               ),
              // //   ),
              // // ),
              // const SizedBox(height: 20.0),
              // Text(
              //   'Post Caption'.toUpperCase(),
              //   style: const TextStyle(
              //     fontSize: 15.0,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              // TextFormField(
              //   // initialValue: viewModel.description,
              //   decoration: const InputDecoration(
              //     hintText: 'Eg. This is very beautiful place!',
              //     focusedBorder: UnderlineInputBorder(),
              //   ),
              //   maxLines: null,
              //   // onChanged: (val) => viewModel.setDescription(val),
              // ),
              const SizedBox(height: 20.0),
              Text(
                'Location'.toUpperCase(),
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // ListTile(
              //   contentPadding: const EdgeInsets.all(0.0),
              //   title: SizedBox(
              //     width: 250.0,
              //     child: TextFormField(
              //       controller: viewModel.locationTEC,
              //       decoration: const InputDecoration(
              //         contentPadding: EdgeInsets.all(0.0),
              //         hintText: 'United States,Los Angeles!',
              //         focusedBorder: UnderlineInputBorder(),
              //       ),
              //       maxLines: null,
              //       onChanged: (val) => viewModel.setLocation(val),
              //     ),
              //   ),
              // trailing: IconButton(
              //   tooltip: "Use your current location",
              //   icon: const Icon(
              //     CupertinoIcons.map_pin_ellipse,
              //     size: 25.0,
              //   ),
              //   iconSize: 30.0,
              //   color: Theme.of(context).colorScheme.secondary,
              //   onPressed: () => viewModel.getLocation(),
              // ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

//   showImageChoices(BuildContext context, PostsViewModel viewModel) {
//     showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       builder: (BuildContext context) {
//         return FractionallySizedBox(
//           heightFactor: .6,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20.0),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10.0),
//                 child: Text(
//                   'Select Image',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const Divider(),
//               ListTile(
//                 leading: const Icon(FeatherIcons.camera),
//                 title: const Text('Camera'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   viewModel.pickImage(camera: true);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(FeatherIcons.image),
//                 title: const Text('Gallery'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   viewModel.pickImage();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
}
