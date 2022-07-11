
import 'package:firebase_database/firebase_database.dart';
import 'package:herewego/models/post_send_model.dart';

import '../models/post_model.dart';

class RTDBService {
  static final _database = FirebaseDatabase.instance.ref();

  static Future<Stream<DatabaseEvent>> addPost(PostSend post) async {
    _database.child("posts").push().set(post.toJson());
    return _database.onChildAdded;
  }

  static Future<List<PostSend>> getPosts(String id) async {
    List<PostSend> items = [];
    Query query =
    _database.ref.child("posts").orderByChild("userId").equalTo(id);
    var snapshot = await query.once();
    for (var item in snapshot.snapshot.children) {
      items.add(PostSend.fromJson(item.value as Map));
    }
    return items;
  }
}
