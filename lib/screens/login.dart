import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kerem/screens/home.dart';
import 'package:kerem/screens/homeuser.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen ({Key? key}) : super (key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your email!");
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: OutlineInputBorder (
          borderRadius: BorderRadius.circular(10)
        ),
        prefixIcon: const Icon(Icons.mail),
        contentPadding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        hintText: "Email",
      ),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Please enter your password");
        }
        if (!regex.hasMatch(value)) {
          return ("Please enter a valid password - Minimum 6 figures - ");
        }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.password),
        contentPadding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        ),
      ),
    );

    final loginButton = Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: Colors.black54,
        child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery
              .of(context)
              .size
              .width,
          onPressed: () {
            signIn(emailController.text, passwordController.text);

          },
          child: const Text("Sign In", textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25,
                color: Colors.white),
          ),
        )
    );


    return Scaffold(
        backgroundColor: const Color(0xFFFCE592),
        appBar: AppBar(
          iconTheme: const IconThemeData (
            color: Colors.black
          ),
          backgroundColor: Colors.transparent,

          elevation: 0,
        ),
        body: Center(
            child: SingleChildScrollView(
                child: Container(
                    color: const Color(0xFFFCE592),
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 250,
                              width: 200,
                              child: Image.asset("assets/logoo.png",
                                  fit: BoxFit.contain),
                            ),
                            emailField,
                            const SizedBox(height: 40),

                            passwordField,
                            const SizedBox(height: 40),

                            loginButton,
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    )
                )
            )
        )
    );
  }

  void signIn (String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
              Fluttertoast.showToast(msg: "Login Successful"),
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreenUser())),
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  /*
  void signIn(String email, String password) async
  {
    if (_formKey.currentState!.validate()) {
        {
          _auth.signInWithEmailAndPassword(email: email, password: password)
              .then((uid) => {
            Fluttertoast.showToast(msg: "Login Successful"),
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomeScreen())),
          }).catchError((e)
          {
            Fluttertoast.showToast(msg: e!.message);
          });
        }
    }
  }*/
}
