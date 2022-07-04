import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewego/pages/home_page.dart';
import 'package:herewego/pages/signin_page.dart';
import 'package:herewego/services/auth_service.dart';

import '../services/prefs_service.dart';
import '../utils/utils_service.dart';

class SignUpPage extends StatefulWidget {
  static const String id = '/sign_up';

  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _doSignUp() {
    String email = emailController.text.toString().toString();
    String name = emailController.text.toString().toString();
    String password = passwordController.text.toString().toString();
    setState(() {
      isLoading = true;
    });
    AuthService.signUpUser(context, email, password, name).then((user) => {
      _getFireBaseUser(user),
    });
  }

  void _getFireBaseUser(User? user)  {
    setState(() {
      isLoading = false;
    });
    if (user != null) {
       Prefs.setData(StorageKey.uid, user.uid).then((value) {
        Navigator.pushReplacementNamed(context, Homepage.id);
      });
    } else {
      Utils.fireToast('Check all Information');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: 'FullName'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(hintText: 'Password'),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    height: 45,
                    onPressed: () {
                      _doSignUp();
                    },
                    color: Colors.redAccent,
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, SignInPage.id);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Sign In',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                )
              ],
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
