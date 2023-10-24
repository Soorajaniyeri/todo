import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todomaster/pages/loginpage.dart';
import 'package:todomaster/pages/todoscreen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  FirebaseAuth check = FirebaseAuth.instance;

  checkStatus() {
    if (check.currentUser != null) {
      Timer(const Duration(seconds: 5), () {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return const TodoScreen();
        }));
      });
    } else {
      Timer(const Duration(seconds: 5), () {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return const LoginPage();
        }));
      });
    }
  }

  @override
  void initState() {
    checkStatus();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            child: SizedBox(),
          ),
          const Center(
            child:
                Image(height: 150, image: AssetImage("assets/checklist.png")),
          ),
          const Expanded(
            child: SizedBox(),
          ),
          Text(
            "TODO MASTER",
            style: GoogleFonts.oswald(
                textStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 5,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      )),
    );
  }
}
