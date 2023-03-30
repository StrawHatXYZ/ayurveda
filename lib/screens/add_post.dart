import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              // TODO: Implement post creation logic
              handleSubmit();
              print(_image!.path + _post.title);
            },
          ),
        ],
      ),
      body: isUploading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  if (_image != null)
                    Image.file(
                      _image!,
                      fit: BoxFit.cover,
                    ),
                  ListTile(
                    leading: const Icon(Icons.description),
                    title: TextField(
                      decoration:
                          const InputDecoration(hintText: 'Description'),
                      onChanged: (value) {
                        setState(() {
                          _post.title = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo),
                    title: const Text('Add a photo'),
                    onTap: getImage,
                  ),
                ],
              ),
            ),
    );
  }
}
