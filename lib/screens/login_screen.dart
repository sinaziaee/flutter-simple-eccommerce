import 'package:ecommerce/components/custom_button.dart';
import 'package:ecommerce/components/custom_text_field.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/screens/sign_up_screen.dart';
import 'package:ecommerce/static_methods.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailController, passwordController;
  Size size;
  FocusNode node;

  DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child('Users');

  String email, password;

  bool showLoadingProgress = false;

  getUser() {
    User user = auth.currentUser;
    if (user != null) {
      getUserInfoFromDatabase(user);
    } else {
      // pass
    }
  }

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    Future.delayed(
      Duration(microseconds: 500),
      () {
        getUser();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    node = FocusScope.of(context);

    return Scaffold(
      appBar: StaticMethods.myAppBar('Login'),
      body: ModalProgressHUD(
        inAsyncCall: showLoadingProgress,
        progressIndicator: kCustomProgressIndicator,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  MyTextField(
                    controller: emailController,
                    text: 'Email',
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  MyTextField(
                    controller: passwordController,
                    text: 'Password',
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  MyButton(
                    text: 'Login',
                    onPressed: () {
                      onLoginPressed();
                    },
                  ),
                  Text('Or'),
                  TextButton(
                    onPressed: () {
                      StaticMethods.simplePopAndPushNavigation(
                          context: context, routeName: SignUpScreen.id);
                    },
                    child: Text('Go to sign up screen'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isValid() {
    email = emailController.text;
    password = passwordController.text;
    if (email.length == 0) {
      StaticMethods.showErrorDialog(context: context, text: 'Fill email');
      return false;
    }
    if (password.length < 6) {
      StaticMethods.showErrorDialog(context: context, text: 'Fill password');
      return false;
    }
    return true;
  }

  uploadInfo() async {
    showLoadingProgress = true;
    setState(() {});
    try {
      print('signing in');
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print('after singing in');
      showLoadingProgress = false;
      setState(() {});
      if (userCredential != null) {
        print('user is: ${userCredential.user}');
        getUserInfoFromDatabase(userCredential.user);
      } else {
        print('user is null');
      }
    } catch (e) {
      print('myError: $e');
      showLoadingProgress = false;
      setState(() {});
    }
  }

  onLoginPressed() {
    if (isValid()) {
      uploadInfo();
    } else {
      // pass
    }
  }

  getUserInfoFromDatabase(User user) async {
    showLoadingProgress = true;
    setState(() {});
    try {
      String name;
      String email;
      String uid;
      await dbRef.child(user.uid).once().then((value) {
        print('---------------------------------------------');
        name = value.value['name'];
        email = value.value['email'];
        uid = value.value['uid'];
      });
      showLoadingProgress = false;
      setState(() {});
      Navigator.pushNamed(
        context,
        HomeScreen.id,
        arguments: {
          'name': name,
          'email': email,
          'uid': uid,
        },
      );
    } catch (e) {
      showLoadingProgress = false;
      setState(() {});
      StaticMethods.showErrorDialog(context: context, text: 'sth went wrong');
      print(e);
    }
  }
}
