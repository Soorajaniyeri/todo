import 'package:cloud_firestore/cloud_firestore.dart';
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
  FirebaseFirestore load = FirebaseFirestore.instance;
  TextEditingController todoText = TextEditingController();

  updateData({required docId}) async {
    await load.collection('todo').doc(docId).update({"todo": todoText.text});
  }

  @override
  Widget build(BuildContext context) {
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
                updateData(docId: widget.docId);
              },
              child: Text("update")),
          Expanded(
            child: StreamBuilder(
                stream: load.collection("todo").doc(widget.docId).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    return Center(child: Text(snapshot.data!['todo']));
                  } else {
                    return SizedBox();
                  }
                }),
          )
        ],
      ),
    );
  }
}
