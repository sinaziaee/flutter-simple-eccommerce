import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/components/message_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../constants.dart';
import '../static_methods.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController controller = TextEditingController();
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

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
        SizedBox(
          height: 10,
        ),
        chatBuilder(),
        SizedBox(
          height: 10,
        ),
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
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: fireStore.collection('messages').orderBy('dateTime', descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // print(snapshot.data.docs.first.data());
          if (snapshot.hasData) {
            // print('-------------------------------------------');
            final messages = snapshot.data.docs;
            return ListView.builder(
              reverse: true,
              itemBuilder: (context, index) {
                return messageContainer(messages[index].data());
              },
              itemCount: messages.length,
            );
          }
          return Center(
            child: kCustomProgressIndicator,
          );
        },
      ),
    );
  }

  Widget messageContainer(Map map) {
    bool isMe = auth.currentUser.email == map['sender'];
    return Container(
      margin: EdgeInsets.only(
        top: 10,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if(!isMe)...[
                Padding(
                  padding: EdgeInsets.only(left: 5, bottom: 5),
                  child: Text(
                    map['sender'],
                    style: TextStyle(
                      fontSize: 11
                    ),
                  ),
                ),
              ],
              Container(
                margin: EdgeInsets.only(
                  left: isMe ? 30 : 10,
                  right: !isMe ? 30: 10,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: isMe ? Colors.lightBlue[100] : Colors.grey[300],
                  borderRadius: BorderRadius.only(
                    topLeft: isMe ? Radius.circular(20) : Radius.circular(5),
                    bottomLeft: isMe ? Radius.circular(5) : Radius.circular(5),
                    topRight: !isMe ? Radius.circular(20) : Radius.circular(5),
                    bottomRight: !isMe ? Radius.circular(5) : Radius.circular(5),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        map['messageBody'],
                      ),
                    ),
                    Text(
                      '${DateTime.parse(map['dateTime'].toDate().toString()).toString().substring(11,16)}',
                      style: TextStyle(
                          fontSize: 10
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  onSendPressed() {
    String text = controller.text;
    if (text.length == 0) {
      return;
    }
    controller.clear();
    uploadMessage(text);
  }

  uploadMessage(String text) {
    fireStore.collection('messages').add({
      'sender': auth.currentUser.email,
      'messageBody': text,
      'dateTime': DateTime.now(),
    });
  }
}
