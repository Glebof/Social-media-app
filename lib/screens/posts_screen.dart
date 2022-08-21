import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/screens/sign_in_screen.dart';
import 'dart:io';
import '../bloc/auth_cubit.dart';
import 'create_post_screen.dart';

class PostsScreen extends StatefulWidget {
  static const String id = "posts_screen";

  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // Create post
          IconButton(
              onPressed: () {
                final picker = ImagePicker();
                picker
                    .pickImage(source: ImageSource.gallery, imageQuality: 40)
                    .then((xFile) {
                  if (xFile != null) {
                    final File file = File(xFile.path);

                    Navigator.of(context)
                        .pushNamed(CreatePostScreen.id, arguments: file);
                  }
                });
              },
              icon: Icon(Icons.add)),
          IconButton(
              onPressed: () {
                context.read<AuthCubit>().signOut().then((_) =>
                    Navigator.of(context)
                        .pushReplacementNamed(SignInScreen.id));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: ListView.builder(
          itemCount: 0,
          itemBuilder: (context, index) {
        return Container();
      }),
    );
  }
}
