import 'package:flutter/material.dart';
import '../models/post_send_model.dart';
import '../services/auth_service.dart';
import '../services/prefs_service.dart';
import '../services/rtdb_service.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  static const String id = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PostSend> items = [];

  @override
  void initState() {
    super.initState();
    _apiGetPosts();
  }

  void _apiGetPosts() async {
    var id = await Prefs.loadUserId();
    RTDBService.getPosts(id!).then((post) => {_respPosts(post)});
  }

  void _respPosts(List<PostSend> post) {
    setState(() {
      items = post;
    });
  }

  void _openDetail() async {
    Map? result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const DetailPage();
        },
      ),
    );
    if (result != null && result.containsKey('data')) {
      _apiGetPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: const Text('All Posts'),
        actions: [
          IconButton(
            onPressed: () {
              AuthService.signOutUser(context);
            },
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return itemOfList(items[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openDetail,
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget itemOfList(PostSend post) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                post.firstName,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                post.lastName,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            post.date,
            style: const TextStyle(color: Colors.black45, fontSize: 17),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            post.content,
            style: const TextStyle(color: Colors.black54, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
