import 'package:firebase_auth/firebase_auth.dart';
import 'package:health/models/user_model.dart ' as user_model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health/models/post_model.dart';

class Util {
  Future<user_model.User> getUser({String uuid = ""}) async {
    final user = FirebaseAuth.instance.currentUser!;
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((value) => user_model.User.fromDoc(value));
  }

  Future<DocumentReference<Map<String, dynamic>>> uploadPost(Post post) async {
    print(post.imageUrl);
    print(post.toMap());
    return await FirebaseFirestore.instance
        .collection('posts')
        .add(post.toMap());
  }

  Future<List<Post>> getPosts() async {
    List<Post> posts = [];
    final docs = await FirebaseFirestore.instance
        .collection('posts')
        .orderBy("timestamp")
        .get();
    for (var doc in docs.docs) {
      posts.add(Post.fromDoc(doc));
    }
    return posts;
  }
}
