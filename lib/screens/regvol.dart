import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kerem/model/user_model.dart';
import 'package:kerem/screens/home.dart';
import 'package:kerem/screens/homeuser.dart';

class RegVol extends StatefulWidget {
  const RegVol({Key? key}) : super(key: key);

  @override
  _RegVolState createState() => _RegVolState();
}

class _RegVolState extends State<RegVol> {

  final _formKey = GlobalKey<FormState>();
  int currentStep = 0;
  final _auth = FirebaseAuth.instance;
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

  List <Step> getSteps(
      emailField,
      firstnameField,
      lastnameField,
      passwordField,
      confirmPasswordField,
      addressField,
      postcodeField,
      contactNoField,
      emergencyContactField,
      currentEmploymentField,

      ) => [

    Step(isActive: currentStep >= 0,
        title: const Text("Account"),
        state: currentStep <= 0 ?StepState.editing :StepState.complete,
        content: Column(
          children: <Widget>[
            emailField,
            passwordField,
            firstnameField,
            lastnameField,
          ],
        )),
    Step(isActive: currentStep >= 1,
        title: const Text("Details"),
        state: currentStep <= 1 ?StepState.editing :StepState.complete,
        content: Column(
          children: <Widget>[
            addressField,
            postcodeField,
            contactNoField,
            emergencyContactField,
            currentEmploymentField,

          ],
        )),

    Step(isActive: currentStep >= 2,
        title: const Text("DBS Check"),
        state: currentStep <= 2 ?StepState.editing :StepState.complete,
        content: Container()),

    Step(isActive: currentStep >= 3,
        title: const Text("Complete"),
        state: StepState.complete,
        content: Container()),
  ];

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
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.mail),
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
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
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
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
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
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.password),
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
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.password),
        hintText: "Confirm your Password",
      ),
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
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
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
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
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
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
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
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        hintText: "Emergency Contact",
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
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        hintText: "Current employment (If unemployed, type 'N')",
      ),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        iconTheme: const IconThemeData (
        color: Colors.black
    ),
    backgroundColor: const Color(0xFFFCE592),
    elevation: 0,
    ),

    body: Stepper(
      type: StepperType.vertical ,
      steps: getSteps(
          emailField,
          firstnameField,
          lastnameField,
          passwordField,
          confirmPasswordField,
          addressField,
          postcodeField,
          contactNoField,
          emergencyContactField,
          currentEmploymentField),
        currentStep: currentStep,
        onStepContinue: () {
          final isLastStep = currentStep == getSteps(
              emailField,
              firstnameField,
              lastnameField,
              passwordField,
              confirmPasswordField,
              addressField,
              postcodeField,
              contactNoField,
              emergencyContactField,
              currentEmploymentField).length - 1;
          if (isLastStep) {
            print ('completed');
          }
         else {
                  setState(() => currentStep += 1 );
                  }},
        onStepCancel:
          currentStep == 0 ? null : () => setState(() => currentStep -= 1),
        ));
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

      UserModel userModel = UserModel();

      userModel.email = user!.email;
      userModel.uid = user.uid;
      userModel.firstName = firstNameController.text;
      userModel.lastName = lastNameController.text;
      userModel.postcode = postcodeController.text;
      userModel.contactNo = contactNoFieldController.text;
      userModel.emergencyC = emergencyContactController.text;
      userModel.currentEm = currentEmploymentController.text;

      await firebaseFirestore
          .collection("volunteer")
          .doc(user.uid)
          .set(userModel.toMap());
      Fluttertoast.showToast(msg: "Account Created");

      Navigator.pushAndRemoveUntil(
          (context),
          MaterialPageRoute(builder: (context)
          => const HomeScreen()),
              (route) => false);
    }

}
