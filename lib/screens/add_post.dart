import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:health/models/post_model.dart';
import 'package:health/util.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  bool isUploading = false;
  File? _image;
  final Post _post = Post(
      name: "",
      title: "",
      timestamp: Timestamp.now(),
      likes: 0,
      imageUrl: "",
      authorId: FirebaseAuth.instance.currentUser!.uid);
  final picker = ImagePicker();
  final storageRef = FirebaseStorage.instance.ref("posts/");

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  void handleSubmit() async {
    setState(() {
      isUploading = true;
    });
    final user = await Util().getUser();
    setState(() {
      _post.profileUrl = user.imageUrl;
      _post.name = user.fullName;
    });
    if (_image?.path != null) {
      final postImg = storageRef
          .child('post_${_post.name}_${_post.timestamp.millisecondsSinceEpoch}')
          .putFile(_image!)
          .snapshotEvents
          .listen((TaskSnapshot taskSnapshot) async {
        switch (taskSnapshot.state) {
          case TaskState.running:
            final progress = 100.0 *
                (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
            print("Upload is $progress% complete.");
            break;
          case TaskState.paused:
            print("Upload is paused.");
            break;
          case TaskState.canceled:
            print("Upload was canceled");
            break;
          case TaskState.error:
            //show snackbar
            print("Upload failed");
            setState(() {
              isUploading = false;
            });
            return;

          case TaskState.success:
            final url = await taskSnapshot.ref.getDownloadURL();
            setState(() {
              _post.imageUrl = url;
              _post.timestamp = Timestamp.now();
            });
            await Util().uploadPost(_post);

            setState(() {
              isUploading = false;
              _image = null;
            });

            break;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isUploading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: TextFormField(
                      minLines:
                          6, // any number you need (It works as the rows for the textarea)
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        // fillColor: Colors.white,
                        filled: true,
                        hintText: 'What\'s on your mind?',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        border: border(context),
                        enabledBorder: border(context),
                        focusedBorder: focusBorder(context),
                      ),

                      //decoration like signup page input fields

                      onChanged: (value) {
                        setState(() {
                          _post.title = value;
                        });
                      },
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        // Image picker with add icon
                        child: GestureDetector(
                          onTap: getImage,
                          child: Row(
                            children: [
                              _image != null
                                  ? Image.file(
                                      _image!,
                                      fit: BoxFit.cover,
                                      height: 120.0,
                                      width: 120.0,
                                    )
                                  : Container(
                                      height: 90.0,
                                      width: 90.0,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey[400]!,
                                          width: 1,
                                        ),
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.add_a_photo,
                                            color: Colors.grey,
                                          ),
                                          const Text(
                                            'Add Image',
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      )),
                            ],
                          ),
                        ),
                      ),
                      //Button to remove image
                      _image != null
                          ? Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _image = null;
                                  });
                                },
                                child: const Text('Remove Image',
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.red,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      //full width Button to submit post with icon
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 45.0,
                    width: 200.0,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      // highlightElevation: 4.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Submit post'.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          const Icon(
                            FeatherIcons.check,
                            color: Colors.white,
                            size: 16.0,
                          )
                        ],
                      ),
                      onPressed: () async {
                        if (_post.title.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter a title'),
                            ),
                          );
                          return;
                        }

                        setState(() {
                          isUploading = true;
                        });
                        handleSubmit();
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  border(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide(
        color: Colors.grey[500]!,
        width: 0.4,
      ),
    );
  }

  focusBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(12.0),
      ),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.secondary,
        width: 1.0,
      ),
    );
  }
}
