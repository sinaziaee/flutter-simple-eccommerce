import 'package:ecommerce/components/custom_button.dart';
import 'package:ecommerce/components/custom_text_field.dart';
import 'package:ecommerce/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

  Size size;
  FocusNode node;


  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyTextField(
                controller: emailController,
                text: 'Email',
              ),
              MyTextField(
                controller: nameController,
                text: 'Full Name',
              ),
              MyTextField(
                controller: passwordController,
                text: 'Password',
              ),
              MyTextField(
                controller: rePasswordController,
                text: 'Re-password',
              ),
              MyButton(
                text: 'Login',
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
    );
  }

  bool isValid() {
    String email = emailController.text;
    String password = passwordController.text;
    String rePassword = rePasswordController.text;
    String name = nameController.text;
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

  uploadInfo() {}

  onSignUpPressed() {
    if (isValid()) {
      uploadInfo();
    } else {
      // pass
    }
  }
}
