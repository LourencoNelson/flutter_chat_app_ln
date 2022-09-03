import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final firestore = FirebaseFirestore.instance;
User? loggedUser;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final auth = FirebaseAuth.instance;

  String? messageText;

  @override
  void initState() {
    super.initState;
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = auth.currentUser;
      if (user != null) {
        loggedUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat',
          style: TextStyle(fontFamily: 'Quicksand'),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut();
              Navigator.popUntil(context, ModalRoute.withName('/'));
              // messagesStream();
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const MessageStream(),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.blueAccent, width: 1.5),
              ),
            ),
            child: Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        // hintText: 'Enter your email',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            // bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 1.3),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            // bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 2.0),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            // bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                      ),
                      controller: messageTextController,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageText = messageTextController.text;
                      firestore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedUser!.email,
                      }).catchError((e) {
                        print(e);
                      });
                      messageTextController.clear();
                    },
                    child: const Text(
                      'Send',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        List<Message> messageWidgets = [];
        if (snapshot.hasData) {
          final messages = snapshot.data!.docs.reversed;

          for (var message in messages) {
            // final messageData = message.data as List;
            final messageText = message['text'];
            // message['text'];
            final messageSender = message['sender'];

            final currentUser = loggedUser!.email;

            // if (currentUser == messageSender) {}

            final messageWidget = Message(
              sender: messageSender,
              text: messageText,
              isMe: currentUser == messageSender,
            );

            messageWidgets.add(messageWidget);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messageWidgets,
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class Message extends StatelessWidget {
  const Message(
      {Key? key, required this.sender, required this.text, required this.isMe})
      : super(key: key);
  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Text(
              sender,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ),
          Material(
            shape: RoundedRectangleBorder(
              borderRadius: isMe
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      // bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )
                  : const BorderRadius.only(
                      topRight: Radius.circular(10),
                      // topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      // bottomRight: Radius.circular(10),
                    ),
              side: const BorderSide(color: Colors.blueAccent, width: 1.5),
            ),
            elevation: 8,
            // borderRadius: isMe
            //     ? const BorderRadius.only(
            //         topLeft: Radius.circular(10),
            //         // bottomLeft: Radius.circular(10),
            //         bottomRight: Radius.circular(10),
            //       )
            //     : const BorderRadius.only(
            //         topRight: Radius.circular(10),
            //         // topLeft: Radius.circular(10),
            //         bottomLeft: Radius.circular(10),
            //         // bottomRight: Radius.circular(10),
            //       ),
            color: isMe ? Colors.blueAccent : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  color: isMe ? Colors.white : Colors.blueAccent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
