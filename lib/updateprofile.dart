import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdatePro extends StatefulWidget {
  UpdatePro({super.key});

  @override
  State<UpdatePro> createState() => _UpdateProState();
}

class _UpdateProState extends State<UpdatePro> {
  updateData({required uid}) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("logindetails")
        .doc(uid)
        .update({"name": "good"});
  }

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("logindetails")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  name.text = snapshot.data!.docs[0]['name'];
                  email.text = snapshot.data!.docs[0]['email'];

                  return Column(

                    
                    children: [
                      // Text(snapshot.data!.docs[0]['name']),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text(snapshot.data!.docs[0]['email']),
                      //     IconButton(
                      //         onPressed: () {
                      //           updateData(uid: snapshot.data!.docs[0].id);
                      //         },
                      //         icon: Icon(Icons.edit))
                      //   ],
                      // ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black))),
                            controller: name),
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black))),
                            controller: email),
                      )
                    ],
                  );
                } else {
                  return SizedBox();
                }
              }),
          ElevatedButton(onPressed: () {}, child: Text("update"))
        ],
      )),
    );
  }
}
