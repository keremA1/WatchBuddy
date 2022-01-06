import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kerem/model/user_model.dart';
import 'package:kerem/screens/login.dart';

class HomeScreenUser extends StatefulWidget {
  const HomeScreenUser({Key? key}) : super(key: key);

  @override
  _HomeScreenUserState createState() => _HomeScreenUserState();
}

class _HomeScreenUserState extends State<HomeScreenUser> {

  final _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
    .collection("users")
    .doc(user!.uid)
    .get()
    .then((value){
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                            ActionChip(label: const Text("Logout"),

                              backgroundColor: Colors.white,
                              shadowColor: Colors.black,
                              elevation: 5,
                              onPressed: () {
                              logout(context);
                            },)

                          ],
                        ),
                      ),
                    )
                )
            )
        )
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute
      (builder: (context) => const LoginScreen()));
  }


}
