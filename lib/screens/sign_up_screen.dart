import 'package:ecommerce/components/custom_button.dart';
import 'package:ecommerce/components/custom_text_field.dart';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_database/firebase_database.dart';
import '../constants.dart';
import '../static_methods.dart';

class SignUpScreen extends StatefulWidget {
  static String id = 'sign_up_screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController,
      passwordController,
      nameController,
      rePasswordController;

  DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child('Users');

  Size size;
  FocusNode node;
  FirebaseAuth auth = FirebaseAuth.instance;

  String email, password, rePassword, name;

  bool showLoadingProgress = false;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    node = FocusScope.of(context);
    // args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: StaticMethods.myAppBar('Sign Up'),
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
                    controller: nameController,
                    text: 'Full Name',
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  MyTextField(
                    controller: passwordController,
                    text: 'Password',
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  MyTextField(
                    controller: rePasswordController,
                    text: 'Re-password',
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  MyButton(
                    text: 'Sign Up',
                    onPressed: () {
                      onSignUpPressed();
                    },
                  ),
                  Text('Or'),
                  TextButton(
                    onPressed: () {
                      StaticMethods.simplePopAndPushNavigation(
                          context: context, routeName: LoginScreen.id);
                    },
                    child: Text('Go to login screen'),
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
    rePassword = rePasswordController.text;
    name = nameController.text;
    if (email.length == 0) {
      StaticMethods.showErrorDialog(context: context, text: 'Fill email');
      return false;
    }
    if (name.length == 0) {
      StaticMethods.showErrorDialog(context: context, text: 'Fill Name');
      return false;
    }
    if (password.length == 0) {
      StaticMethods.showErrorDialog(context: context, text: 'Fill password');
      return false;
    }
    if (rePassword.length == 0) {
      StaticMethods.showErrorDialog(context: context, text: 'Fill re-password');
      return false;
    }
    if (password != rePassword) {
      StaticMethods.showErrorDialog(
          context: context, text: 'Password and rePassword do not match');
      return false;
    }
    return true;
  }

  uploadInfo() async {
    showLoadingProgress = true;
    setState(() {});
    try {
      print('signing in');
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('after singing in');
      if (userCredential != null) {
        print('user is: ${userCredential.user}');
        uploadToDatabase(userCredential.user, nameController.text);
      } else {
        print('user is null');
      }
    } catch (e) {
      print('myError: $e');
      showLoadingProgress = false;
      setState(() {});
    }
  }

  onSignUpPressed() {
    if (isValid()) {
      uploadInfo();
    } else {
      // pass
    }
  }

  uploadToDatabase(User user, String name) async {
    try{
      await dbRef.child(user.uid).set({
        'name': name,
        'uid': user.uid,
        'email': user.email,
      });
      showLoadingProgress = false;
      setState(() {});
      Navigator.popAndPushNamed(
        context,
        HomeScreen.id,
        arguments: {
          'name': name,
          'email': email,
          'uid': user.uid,
        },
      );
    }
    catch(e){
      showLoadingProgress = false;
      setState(() {});
      StaticMethods.showErrorDialog(context: context, text: 'sth went wrong');
      print(e);
    }
  }
}
