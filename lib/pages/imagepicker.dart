import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  ImagePicker picker = ImagePicker();
  File? pickImages;
  //FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore store = FirebaseFirestore.instance;
  UploadTask? task;

  pickImage() async {
    XFile? store = await picker.pickImage(source: ImageSource.gallery);
    if (store != null) {
      setState(() {
        pickImages = File(store.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  pickImage();
                },
                child: Text("upload")),
            pickImages == null
                ? SizedBox()
                : Center(
                    child: Center(
                      child: Image(height: 300, image: FileImage(pickImages!)),
                    ),
                  ),
            ElevatedButton(
                onPressed: () async {
                  var responce = FirebaseStorage.instance
                      .ref()
                      .child("myimage/${pickImages!.path}");
                  task = responce.putFile(pickImages!);
                  var taskUrl = await task!.whenComplete(() {});
                  var link = await taskUrl.ref.getDownloadURL();

                  print(link);
                  await store.collection("images").add({"image": link});
                },
                child: Text("upload")),
          ],
        ),
      ),
    );
  }
}
