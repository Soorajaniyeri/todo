import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImagePickerFirebase extends StatefulWidget {
  const ImagePickerFirebase({super.key});

  @override
  State<ImagePickerFirebase> createState() => _ImagePickerFirebaseState();
}

class _ImagePickerFirebaseState extends State<ImagePickerFirebase> {

  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
    );
  }
}
