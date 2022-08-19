import 'package:flutter/material.dart';
import 'package:social_media_app/screens/sign_up_screen.dart';

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
                       FocusScope.of(context).requestFocus(_passwordFocusNode);
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
                   }, child: Text("Sign in")),
                   TextButton(onPressed: () {
                     // TODO:- Go to sing up screen
                     Navigator.of(context).pushReplacementNamed(SignUpScreen.id);

                     // Go to SignIn screed
                   }, child: Text("Sign up instead")),
                 ],
               ),
             ),
           ),
         ),
       ),
     );
   }
 }
