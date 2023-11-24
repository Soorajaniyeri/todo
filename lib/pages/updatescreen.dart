import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateScreen extends StatefulWidget {
  final docId;
  const UpdateScreen({super.key, required this.docId});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final currentUser = FirebaseAuth.instance.currentUser;

  TextEditingController todoText = TextEditingController();

  updateTodoData({required docId}) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser!.uid)
        .collection("todo")
        .doc(docId)
        .update({"todo": todoText.text});

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.docId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          'TODO MASTER',
          style: GoogleFonts.oswald(
              textStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: todoText,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                updateTodoData(docId: widget.docId);
              },
              child: Text("update")),
        ],
      ),
    );
  }
}
