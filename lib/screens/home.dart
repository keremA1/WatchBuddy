import 'package:flutter/material.dart';
import 'package:kerem/screens/login.dart';
import 'package:kerem/screens/regvol2.dart';
import 'package:kerem/screens/user%20sign%20up/reguser.dart';
import 'package:kerem/screens/regvol.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final userSignUpButton = Material (
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: Colors.black54,
        child: MaterialButton(
          padding: const EdgeInsets.all(60.0),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegUser()));
          },
          child: const Text("User Sign Up", textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25,
                color: Colors.white),
          ),
        )
    );

    final volSignUpButton = Material (
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: Colors.black54,
        child: MaterialButton(
          padding: const EdgeInsets.all(60.0),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegVolNew()));
          },
          child: const Text("Volunteer Sign Up", textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25,
                color: Colors.white),
          ),
        )
    );

    final signInButton = Material (
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: Colors.black54,
        child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginScreen()));
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
        body: Center(
            child: SingleChildScrollView(
                child: Container(
                    color: const Color(0xFFFCE592),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 180,
                              width: 180,
                              child: Image.asset("assets/logoo.png",
                                  fit: BoxFit.contain),
                            ),

                            userSignUpButton,
                            const SizedBox(height: 40, width: 200),

                            volSignUpButton,
                            const SizedBox(height: 40, width: 200),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Text("Already have an account? ", style: TextStyle(fontSize: 20, height: 2)),
                              ],
                            ),

                            signInButton,
                            const SizedBox(height: 40, width: 40),

                          ],
                        ),
                      ),
                    )
                )
            )
        )
    );
  }
}

