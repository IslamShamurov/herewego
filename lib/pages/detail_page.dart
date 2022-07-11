import 'package:flutter/material.dart';
import 'package:herewego/models/post_send_model.dart';

import '../models/post_model.dart';
import '../services/prefs_service.dart';
import '../services/rtdb_service.dart';

class DetailPage extends StatefulWidget {
  static const String id = '/detail_page';

  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  void _addPost() async {
    String firstName = firstNameController.text.toString().trim();
    String lastName = lastNameController.text.toString().trim();
    String content = contentController.text.toString().trim();
    String date = dateController.text.toString().trim();
    var id = await Prefs.loadUserId();
    RTDBService.addPost(PostSend(id!, firstName, lastName, content, date))
        .then((value) => {_respAddPost()});
  }

  void _respAddPost() {
    Navigator.pop(context, {'data': 'done'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text('Add Post'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  hintText: 'First name',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  hintText: 'Last name',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  hintText: 'Content',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(
                  hintText: 'Date',
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: MaterialButton(
                  onPressed: _addPost,
                  color: Colors.deepOrange,
                  child: const Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
