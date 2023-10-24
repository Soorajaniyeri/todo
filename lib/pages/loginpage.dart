import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todomaster/pages/todoscreen.dart';

import '../widgets/textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  FirebaseAuth login = FirebaseAuth.instance;

  String? userEmail;

  firebaseLogin({required email, required password}) async {
    try {
      UserCredential userData = await login.signInWithEmailAndPassword(
          email: email, password: password);
      if (userData.user != null) {
        setState(() {
          userEmail = userData.user!.email;
        });
        Timer(Duration(seconds: 3), () {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return TodoScreen();
          }));
        });
      }
    } on FirebaseAuthException catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Center(
                child: Image(
                    height: 150, image: AssetImage("assets/checklist.png")),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "Email",
                      style: GoogleFonts.oswald(
                          textStyle: TextStyle(fontSize: 20)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "Password",
                      style: GoogleFonts.oswald(
                          textStyle: TextStyle(fontSize: 20)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: pass,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white))),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  firebaseLogin(email: email.text, password: pass.text);
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Center(
                    child: Text(
                      "Login",
                      style: GoogleFonts.oswald(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Dont have an account..?? ",
                    style: GoogleFonts.oswald(
                        textStyle: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue)),
                      onPressed: () {},
                      child: Text(
                        "  Register  ",
                        style: GoogleFonts.oswald(
                            textStyle: TextStyle(color: Colors.white)),
                      ))
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
