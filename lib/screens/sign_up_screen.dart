import 'package:flutter/material.dart';
import 'package:social_media_app/screens/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {

  static const String id = "sing_up_screen";

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _username = "";
  String _password = "";

  late final FocusNode _passwordFocusNode;
  late final FocusNode _usernameFocusNode;

  @override
  void initState() {
    super.initState();

    _passwordFocusNode = FocusNode();
    _usernameFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();

    _passwordFocusNode.dispose();
    _usernameFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      labelText: "Enter your email"
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_){
                      FocusScope.of(context).requestFocus(_usernameFocusNode);
                    },
                    onSaved: (value) {
                      _email = value!.trim();
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please enter your email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),

                  // userName
                  TextFormField(
                    focusNode: _usernameFocusNode,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: "Enter your username"
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_){
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    onSaved: (value) {
                      _email = value!.trim();
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please enter your username";
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
                        labelText: "Enter your password"
                    ),
                    textInputAction: TextInputAction.done,

                    obscureText: true,
                    onFieldSubmitted: (_){
                      // TODO:- Submit form
                    },
                    onSaved: (value) {
                      _email = value!.trim();
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please enter your password";
                      }
                      if(value.length > 5){

                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),

                  TextButton(onPressed: () {
                    // TODO:- Submit form
                  }, child: Text("Sign up")),
                  TextButton(onPressed: () {
                    // TODO:- Go to sing in screen
                    Navigator.of(context).pushReplacementNamed(SignInScreen.id);

                    // Go to SignIn screed
                  }, child: Text("Sign in instead")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
