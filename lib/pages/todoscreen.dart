import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todomaster/pages/loginpage.dart';
import 'package:todomaster/pages/registration.dart';
import 'package:todomaster/pages/splashscreen.dart';
import 'package:todomaster/pages/updatescreen.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  FirebaseFirestore data = FirebaseFirestore.instance;
  FirebaseAuth fetch = FirebaseAuth.instance;
  String? userEmail;
  TextEditingController updateTodoText = TextEditingController();
  TextEditingController newTodoText = TextEditingController();

  // creating to fetch current user function

  fetchUser() {
    setState(() {
      userEmail = fetch.currentUser!.email;
    });
  }

  // creating firestore data loading function

  addData() async {
    await data.collection("todo").add({"todo": newTodoText.text});
  }

  logout() async {
    await fetch.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return LoginPage();
    }));
  }

  deleteData({required docId}) async {
    await data.collection("todo").doc(docId).delete();
  }

  // updateData({required docId}) {
  //   data.collection("todo").doc(docId).update({"todo": todoText.text});
  // }

  addDataAlertBox() {
    return AlertDialog(
      title: Text(
        "add new todo",
        style: GoogleFonts.oswald(
            textStyle:
                TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        textAlign: TextAlign.center,
      ),
      content: TextField(
        decoration: InputDecoration(
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black))),
        controller: newTodoText,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  addData();
                  newTodoText.clear();

                  Navigator.pop(context);
                },
                child: Text("submit")),
          ],
        )
      ],
    );
  }

  // updateAlertBox({required docId}) {
  //   return AlertDialog(
  //     title: Text(
  //       "update your todo",
  //       style: GoogleFonts.oswald(
  //           textStyle:
  //               TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
  //       textAlign: TextAlign.center,
  //     ),
  //     content: TextField(
  //       decoration: InputDecoration(
  //           focusedBorder:
  //               OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
  //           border: OutlineInputBorder(
  //               borderSide: BorderSide(color: Colors.black))),
  //       controller: todoText,
  //     ),
  //     actions: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           ElevatedButton(
  //               onPressed: () {
  //                 updateData(docId: docId);
  //                 Navigator.pop(context);
  //               },
  //               child: Text("submit")),
  //         ],
  //       )
  //     ],
  //   );
  // }

  @override
  void initState() {
    fetchUser();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.blue,
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return addDataAlertBox();
                });
          }),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              //height: 200,
              width: 350,
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 60,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  userEmail == null
                      ? SizedBox()
                      : Text(userEmail!,
                          style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20))),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: (){

                      logout();
                    },
                    child: Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Center(
                          child: Text(
                        "Logout",
                        style: GoogleFonts.oswald(),
                      )),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "TODO MASTER",
          style: GoogleFonts.oswald(
              textStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: StreamBuilder(
                stream: data.collection("todo").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage("assets/checklist.png"),
                              height: 100,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Add your First Todo",
                              style: GoogleFonts.oswald(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.blue)),
                            )
                          ],
                        ),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                // todoText.text =
                                //     snapshot.data!.docs[index]['todo'];
                                // showDialog(
                                //     context: context,
                                //     builder: (context) {
                                //       return alertBox(
                                //           docId: snapshot.data!.docs[index].id);
                                //     });

                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return UpdateScreen(
                                      docId: snapshot.data!.docs[index].id);
                                }));
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 20, bottom: 20, right: 10),
                                margin: const EdgeInsets.all(10),
                                //height: 70,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          blurRadius: 10,
                                          spreadRadius: 1),
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Center(
                                    child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        snapshot.data!.docs[index]['todo'],
                                        style: GoogleFonts.oswald(
                                            textStyle: TextStyle(fontSize: 18)),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          deleteData(
                                              docId: snapshot
                                                  .data!.docs[index].id);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red.shade300,
                                        ))
                                  ],
                                )),
                              ),
                            );
                          });
                    }
                  }

                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Image(image: AssetImage("assets/checklist.png")),
                    );
                  } else {
                    return Center(
                      child: Text("No todo found"),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
