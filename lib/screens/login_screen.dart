import 'package:ecommerce/components/custom_button.dart';
import 'package:ecommerce/components/custom_text_field.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/screens/sign_up_screen.dart';
import 'package:ecommerce/static_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
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
      body: SafeArea(
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
    );
  }

  bool isValid() {
    String email = emailController.text;
    String password = passwordController.text;
    if (email.length == 0) {
      StaticMethods.showErrorDialog(context: context, text: 'Fill email');
      return false;
    }
    if (password.length == 0) {
      StaticMethods.showErrorDialog(context: context, text: 'Fill password');
      return false;
    }
    return true;
  }

  uploadInfo() {}

  onLoginPressed() {
    if (isValid()) {
      uploadInfo();
    } else {
      // pass
    }
  }
}
