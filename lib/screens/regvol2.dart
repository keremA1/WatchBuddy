import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kerem/model/user_model.dart';
import 'package:kerem/model/vol_model.dart';
import 'package:kerem/screens/home.dart';
import 'package:kerem/screens/homeuser.dart';

class RegVolNew extends StatefulWidget {
  const RegVolNew({Key? key}) : super(key: key);

  @override
  _RegVolNState createState() => _RegVolNState();
}

class _RegVolNState extends State<RegVolNew> {

  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  var times = ['12am - 6am', '6am - 12pm', '12pm - 6pm', '6pm - 12am'];
  String timeValue = '12am - 6am';

  var days = ['All days', 'Weekdays', 'Weekends'];
  String daysValue = 'Weekdays';

  String? errorMessage;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final addressController = TextEditingController();
  final postcodeController = TextEditingController();
  final contactNoFieldController = TextEditingController();
  final emergencyContactController= TextEditingController();
  final currentEmploymentController = TextEditingController();
  final prevEmploymentController = TextEditingController();

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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(Icons.mail),
        contentPadding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        hintText: "Email",
      ),
    );

    final firstnameField = TextFormField(
      autofocus: false,
      controller: firstNameController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Please enter your name");
        }
        if (!regex.hasMatch(value)) {
          return ("Please enter a valid name");
        }
        return null;
      },
      onSaved: (value) {
        firstNameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(Icons.account_circle),
        contentPadding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        hintText: "First Name",
      ),
    );

    final lastnameField = TextFormField(
      autofocus: false,
      controller: lastNameController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your last name");
        }
        return null;
      },
      onSaved: (value) {
        lastNameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(Icons.account_circle),
        contentPadding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        hintText: "Last Name",
      ),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Please enter a password");
        }
        if (!regex.hasMatch(value)) {
          return ("Please enter a valid password - Minimum 6 figures - ");
        }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(Icons.password),
        contentPadding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        hintText: "Password",
      ),
    );

    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordController,
      obscureText: true,
      validator: (value) {
        if (confirmPasswordController.text != passwordController.text)
        {
          return ("Password does not match");
        }
        return null;
      },
      onSaved: (value) {
        confirmPasswordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(Icons.password),
        contentPadding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        hintText: "Confirm your Password",
      ),
    );

    final continueButton = Material (
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: Colors.black54,
        child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signUp(emailController.text, passwordController.text);
          },
          child: const Text("Sign Up", textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25,
                color: Colors.white),
          ),
        )
    );

    final addressField = TextFormField(
      autofocus: false,
      controller: addressController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your address");
        }
        return null;
      },
      onSaved: (value) {
        addressController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(Icons.account_circle),
        hintText: "Address",
      ),
    );

    final postcodeField = TextFormField(
      autofocus: false,
      controller: postcodeController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your postcode");
        }
        return null;
      },
      onSaved: (value) {
        postcodeController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(Icons.account_circle),
        hintText: "Postcode",
      ),
    );

    final contactNoField = TextFormField(
      autofocus: false,
      controller: contactNoFieldController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your contact number");
        }
        return null;
      },
      onSaved: (value) {
        contactNoFieldController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(Icons.account_circle),
        hintText: "Contact Number",
      ),
    );

    final emergencyContactField = TextFormField(
      autofocus: false,
      controller: emergencyContactController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your emergency contact number");
        }
        return null;
      },
      onSaved: (value) {
        emergencyContactController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(Icons.account_circle),
        hintText: "Emergency Contact Number",
      ),
    );

    final currentEmploymentField = TextFormField(
      autofocus: false,
      controller: currentEmploymentController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your current employment status");
        }
        return null;
      },
      onSaved: (value) {
        currentEmploymentController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(Icons.account_circle),
        hintText: "Current employment (If unemployed, type 'N')",
      ),
    );

    final prevEmploymentField = TextFormField(
      autofocus: false,
      controller: prevEmploymentController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your previous employment history");
        }
        return null;
      },
      onSaved: (value) {
        prevEmploymentController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(Icons.account_circle),
        hintText: "Previous employment (If unavailable, type 'N')",
      ),
    );

    final terms = Material (
      color: const Color(0xFFFCE592),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: "By creating an account, "
                "you are agreeing to our terms and conditions.",
            style: const TextStyle(
                fontSize: 15,
                height: 2,
                decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()..onTap = () =>
            (openDialog()),
          ),
        ]),
      ),
    );

    final timesList = Material (
      color: const Color(0xFFFCE592),
      child: DropdownButton(
        items: times.map((itemsName) {
          return DropdownMenuItem(
              value: itemsName,
              child: Text(itemsName));
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            timeValue = value!;
          });

        },
        value: timeValue,
      ),
    );

    final daysList = Material (
      color: const Color(0xFFFCE592),
      child: DropdownButton(
        items: days.map((itemsName) {
          return DropdownMenuItem(
              value: itemsName,
              child: Text(itemsName));
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            daysValue = value!;
          });

        },
        value: daysValue,
      ),
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
                              height: 220,
                              width: 215,
                              child: Image.asset("assets/logoo.png",
                                  fit: BoxFit.contain),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Text("Volunteer Sign Up:", style: TextStyle(fontSize: 23, height: 2)),
                              ],
                            ),

                            Row(
                              children: const <Widget>[
                                Text("Account Details:", style: TextStyle(fontSize: 20, height: 2)),
                              ],
                            ),

                            emailField,
                            const SizedBox(height: 20),

                            passwordField,
                            const SizedBox(height: 20),

                            confirmPasswordField,
                            const SizedBox(height: 20),

                            Row(
                              children: const <Widget>[
                                Text("Personal Details:", style: TextStyle(fontSize: 20, height: 3)),
                              ],
                            ),

                            firstnameField,
                            const SizedBox(height: 20),

                            lastnameField,
                            const SizedBox(height: 20),

                            addressField,
                            const SizedBox(height: 20),

                            postcodeField,
                            const SizedBox(height: 20),

                            contactNoField,
                            const SizedBox(height: 20),

                            emergencyContactField,
                            const SizedBox(height: 20),

                            currentEmploymentField,
                            const SizedBox(height: 20),

                            prevEmploymentField,
                            const SizedBox(height: 20),

                            Row(
                                children: const [
                                  Text("Time Available:  ", style: TextStyle(fontSize: 20, height: 2)),
                                ]
                            ),

                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:  const [
                                  Text("Please select the time you are most suited to work at:  ",
                                      style: TextStyle(fontSize: 15, height: 2)),
                                ]
                            ),

                            timesList,
                            const SizedBox(height: 20),

                            Row(
                                children: const [
                                  Text("Days Available:  ", style: TextStyle(fontSize: 20, height: 2)),
                                ]
                            ),

                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:  const [
                                  Text("Please select the days you are most suited to work on:  ",
                                      style: TextStyle(fontSize: 15, height: 2)),
                                ]
                            ),

                            daysList,
                            const SizedBox(height: 20),

                            Row(
                              children: const <Widget>[
                                Text("DBS Check:  ", style: TextStyle(fontSize: 20, height: 3)),
                                Text("Currently Unavailable", style: TextStyle(fontSize: 15, height: 3))
                              ],
                            ),



                            continueButton,
                            const SizedBox(height: 10),

                            terms,
                            const SizedBox(height: 10)
                          ],
                        ),
                      ),
                    )
                )
            )
        )
    );
  }

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Terms and Conditions',
            textAlign: TextAlign.center, style: TextStyle(
                fontStyle: FontStyle.italic)
        ),
        scrollable: true,
        content: const Text("Terms of use \n \n i) You may use the service if you agree and accept the terms of conditions of Watch Buddy. \n "
            "\nii) There is no age limit for the use of the app. \n "
            "\niii) All volunteers must be above the age of 16 years to assist the users. \n"
            "\niv) You must be honest regarding your visual impairment and not use the app in a harmful or derogatory way. \n "
            "\nv) There will be no tolerance policy towards abusive or unacceptable behavior from users, any such behavior will be dealt with formally and may result in the termination of your account. \n "
            "\nPrivacy \n"
            "\ni) Users will be required to provide personal information including: \n  \n  a)   Full name \n  b)   Date of Birth"
            "\n  c)   Telephone number \n  d)   Home address\n"
            "\nii) Users will be required to share their location to help the volunteers assist their journey as efficiently as possible. \n"
            "\niii) Users must allow access to their camera to allow the volunteer to assist them on their journey. \n"
            "\niv) More information will be required through DBS checks which will be conducted through a professional organization. \n "
            "\nv) Private information will not be shared outside the service and will be used to assist the user only. \n "
            "\nvi) Some calls may be recorded and viewed by the organization to improve the quality of the user's experience. \n"
            "\nLiability \n"
            "\ni) Users are encouraged to trust the service and volunteers who are trained to assist visually impaired. \n"
            "\nii) Volunteers will not do anything to put the user in immediate danger and will always act in the best interest of the user. \n"
            "\niii) If users become injured during the use of this service, Watch Buddy will accept no liability to the injury or death of the user. \n"
            "\niv) All responsibility lies with the user who chose to use the service. \n"
        ),
        actions: [
          TextButton(onPressed: closeWindow, child: const Text('Close'))
        ],
      )
  );

  void closeWindow() {
    Navigator.of(context).pop();
  }

  void signUp (String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFS()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
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


  postDetailsToFS() async {

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    VolModel volModel = VolModel();

    volModel.email = user!.email;
    volModel.uid = user.uid;
    volModel.firstName = firstNameController.text;
    volModel.lastName = lastNameController.text;
    volModel.address = addressController.text;
    volModel.postcode = postcodeController.text;
    volModel.contactNo = contactNoFieldController.text;
    volModel.emergencyC = emergencyContactController.text;
    volModel.currentEm = currentEmploymentController.text;
    volModel.prevEm = prevEmploymentController.text;
    volModel.times = timeValue;
    volModel.days = daysValue;

    await firebaseFirestore
        .collection("volunteer")
        .doc(user.uid)
        .set(volModel.toMap());
    Fluttertoast.showToast(msg: "Account Created");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context)
        => const HomeScreen()),
            (route) => false);
  }
}


