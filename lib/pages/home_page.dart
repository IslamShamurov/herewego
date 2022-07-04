import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:herewego/services/auth_service.dart';

class Homepage extends StatefulWidget {
  static const String id = '/home_page';

  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Center(
        child: MaterialButton(
          color: Colors.red,
          onPressed: () {
            AuthService.signOutUser(context);
          },
          child: const Text(
            'LogOut',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
