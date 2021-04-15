import 'package:ecommerce/components/message_textfield.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../static_methods.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController controller = TextEditingController();

  // FocusNode node;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StaticMethods.myAppBar('Chat Screen'),
      body: SafeArea(
        child: bodyBuilder(),
      ),
    );
  }

  Widget bodyBuilder() {
    return Column(
      children: [
        chatBuilder(),
        CustomMessageTextField(
          controller: controller,
          onSendPressed: () {
            onSendPressed();
          },
        ),
      ],
    );
  }

  Widget chatBuilder() {
    return SizedBox();
  }

  onSendPressed() {
    String text = controller.text;
    if (text.length == 0) {
      return;
    }
    controller.clear();
    uploadMessage(text);
  }

  uploadMessage(String text) {}
}
