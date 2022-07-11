import 'dart:io';

import 'package:flutter/material.dart';
import 'package:herewego/models/post_send_model.dart';
import 'package:herewego/services/store_service.dart';
import 'package:image_picker/image_picker.dart';

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
  File? _image;
  final _picker = ImagePicker();
  bool isLoading = false;

  void _addPost() async {
    String firstName = firstNameController.text.toString().trim();
    String lastName = lastNameController.text.toString().trim();
    String content = contentController.text.toString().trim();
    String date = dateController.text.toString().trim();
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        content.isEmpty ||
        date.isEmpty) return;
    if (_image == null) return;
    _apiUploadImg(firstName, lastName, content, date);
  }

  void _apiUploadImg(
      String firstName, String lastName, String content, String date) async {
    setState(() {
      isLoading = true;
    });
    StoreService.uploadImage(_image!).then(
        (imgUrl) => {_apiAddPost(firstName, lastName, content, date, imgUrl!)});
  }

  void _apiAddPost(String firstName, String lastName, String content,
      String date, String imgUrl) async {
    var id = await Prefs.loadUserId();
    RTDBService.addPost(PostSend(id!, firstName, lastName, content, date,imgUrl))
        .then((value) {
      _respAddPost();
    });
  }

  void _respAddPost() {
    setState(() {
      isLoading = false;
    });
    Navigator.pop(context, {'data': 'done'});
  }

  void _getImage() async {
    XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No Image Selected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text('Add Post'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(30),
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _getImage,
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: _image != null
                          ? Image.file(_image!)
                          : Image.asset('assets/images/img.png'),
                    ),
                  ),
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
          Center(
            child: Visibility(
              visible: isLoading,
              child: const CircularProgressIndicator(),
            ),
          )
        ],
      ),
    );
  }
}
