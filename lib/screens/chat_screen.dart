import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/chat_model.dart';
import '../models/post_model.dart';
import '../widgets/message_list_style.dart';

class ChatScreen extends StatefulWidget {
  static const String id = "chat_screen";

  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  String _message = "";
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Post post = ModalRoute.of(context)!.settings.arguments as Post;

    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("posts")
                    .doc(post.id)
                    .collection("comments").orderBy("timestamp")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text("Error"));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.connectionState == ConnectionState.none) {
                    return Center(child: Text("Loading..."));
                  }
                  return ListView.builder(
                      itemCount: snapshot.data?.docs.length ?? 0,
                      itemBuilder: (context, index) {
                        final QueryDocumentSnapshot doc =
                            snapshot.data!.docs[index];

                        final ChatModel chatModel = ChatModel(
                            message: doc["message"],
                            userID: doc["userID"],
                            userName: doc["userName"],
                            timestamp: doc["timestamp"]);

                        return Align(
                            alignment: chatModel.userID ==
                                currentUserId
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: MessageListStyle(chatModel));
                      });
                },
              ),
            ),
            Container(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextField(
                      controller: _textEditingController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintText: "Enter message",
                      ),
                      onChanged: (value) {
                        _message = value;
                      },
                    ),
                  )),
                  IconButton(
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection("posts")
                            .doc(post.id)
                            .collection("comments")
                            .add({
                              "userID": FirebaseAuth.instance.currentUser!.uid,
                              "userName": FirebaseAuth
                                  .instance.currentUser!.displayName,
                              "message": _message,
                              "timestamp": Timestamp.now(),
                            })
                            .then((value) => print("chat doc added"))
                            .catchError((onError) => print(
                                "Error has occured while adding chet doc"));
                        _textEditingController.clear();

                        setState(() {
                          _message = "";
                        });
                      },
                      icon: Icon(Icons.arrow_forward_ios_rounded))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
