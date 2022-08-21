import 'package:flutter/material.dart';
import 'package:social_media_app/screens/posts_screen.dart';
import 'package:social_media_app/screens/sign_up_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_cubit.dart';

class SignInScreen extends StatefulWidget {
  static const String id = "sing_in_screen";

  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";

  late final FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _passwordFocusNode.dispose();
  }

  void _submit(BuildContext context) {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      // Invalid
      return;
    }
    _formKey.currentState!.save();
    context.read<AuthCubit>().signIn(email: _email, password: _password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (prevState, currentState) {
          if (currentState is AuthSignedIn) {
            // Navigator.of(context).pushReplacementNamed(PostsScreen.id);
          }
          if (currentState is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: Duration(seconds: 2),
              content: Text(currentState.message),
            ));
          }
        },
        builder: (content, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return SafeArea(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: Text("Sodial Media App",
                            style: Theme.of(context).textTheme.headline3),
                      ),
                      SizedBox(height: 15),
                      // email
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            labelText: "Enter your email"),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_passwordFocusNode);
                        },
                        onSaved: (value) {
                          _email = value!.trim();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      // password
                      TextFormField(
                        focusNode: _passwordFocusNode,
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            labelText: "Enter your password"),
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        onFieldSubmitted: (_) {
                          _submit(context);
                        },
                        onSaved: (value) {
                          _password = value!.trim();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your password";
                          }
                          if (value.length < 3) {
                            return "Please enter longer password";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      TextButton(
                          onPressed: () {
                            _submit(context);
                          },
                          child: Text("Sign in")),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(SignUpScreen.id);
                            // Go to SignIn screed
                          },
                          child: Text("Sign up instead")),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
