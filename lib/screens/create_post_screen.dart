import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreatePostScreen extends StatefulWidget {

  static const String id = "create_post_screen";

  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {

  String _descriprion = "";

  Future<void> _submit({required File image}) async {
    FocusScope.of(context).unfocus();

    if(_descriprion.trim().isNotEmpty){
      late String imageUrl;
      // write image to storage
      firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

      await storage.ref("images/${UniqueKey().toString()}.png").putFile(image).then((taskSnapshot) async {
        imageUrl = await taskSnapshot.ref.getDownloadURL();
      });

      FirebaseFirestore.instance.collection("posts").add({
        "timastamp" : Timestamp.now(),
        "userID" : FirebaseAuth.instance.currentUser!.uid,
        "description" : _descriprion,
        "userName" :  FirebaseAuth.instance.currentUser!.displayName,
        "imageURL" : imageUrl,
      }).then((docRef) => docRef.update({"postID" : docRef.id}));

      Navigator.of(context).pop();
    }

  }


  @override
  Widget build(BuildContext context) {

    final File imageFile = ModalRoute.of(context)!.settings.arguments as File;

    return Scaffold(
      appBar: AppBar(
        title: Text("Create post"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width/1.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: FileImage(imageFile),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Enter a description"
                  ),
                  textInputAction: TextInputAction.done,
                  // Limits number of characters
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(100),
                  ],
                  onChanged: (value){
                    _descriprion = value;
                  },
                  onEditingComplete: () {
                    _submit(image: imageFile);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
