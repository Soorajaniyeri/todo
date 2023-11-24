import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todomaster/pages/todoscreen.dart';
import 'package:todomaster/widgets/textfield.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  FirebaseAuth register = FirebaseAuth.instance;
  FirebaseFirestore dataStore = FirebaseFirestore.instance;

  // creating registration function

  firebaseReg({required email, required password, required name}) async {
    try {
      UserCredential userData = await register.createUserWithEmailAndPassword(
          email: email, password: password);
      if (userData.user != null) {
        dataStore
            .collection("users")
            .doc(userData.user!.uid)
            .collection("logindetails")
            .add({"email": email, "name": name});

        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return TodoScreen();
        }));
      }
    } on FirebaseAuthException catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFieldDesign(hintText: "enter your name", controller: name),
          TextFieldDesign(hintText: "enter your email", controller: email),
          TextFieldDesign(hintText: "enter your password", controller: pass),
          ElevatedButton(
              onPressed: () {
                firebaseReg(email: email.text, password: pass.text,name: name.text);
              },
              child: Text("Create Account"))
        ],
      )),
    );
  }
}
