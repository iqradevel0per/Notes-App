import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/models/notes_model.dart';
import 'package:notes_app/screens/home_screen.dart';

class AddNoteController extends GetxController {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  var isLoading = false.obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  var timestamp = DateTime.now().toString();
  var documentsId = DateTime.now().millisecondsSinceEpoch.toString();
  var userId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> addNotes() async {
    var documentsId = DateTime.now().millisecondsSinceEpoch.toString();
    var userId = FirebaseAuth.instance.currentUser!.uid;

    isLoading.value = true;
    NotesModel notesModel = NotesModel(
      title: titleController.text,
      subtitle: subtitleController.text,
      noteId: documentsId,
      timestamp: timestamp,
      userId: userId,
    );

    await _firebaseFirestore
        .collection("notes")
        .doc(documentsId)
        .set(notesModel.toMap())
        .then((value) {
      print("notes added successfully");
      isLoading.value = false;
      titleController.clear();
      subtitleController.clear();
      Get.back();
    }).catchError((error) {
      print("error: $error");
      isLoading.value = false;
    });
  }

  //delete notes

  Future<void> deleteNotes(String noteId) async {
    try {
      await FirebaseFirestore.instance.collection("notes").doc(noteId).delete();
      print("Notes delete successfully");
    } catch (error) {
      print("Error Occured when delete notes!!! $error");
    }
  }

  //update notes
  Future<void> updateNotes(String noteId, Map<String, dynamic> data) async {
    isLoading.value = true;
    try {
      await FirebaseFirestore.instance
          .collection("notes")
          .doc(noteId)
          .update(data);
      Get.to(() => HomeScreen());
      isLoading.value = false;
    } catch (error) {
      print("error occurred when update notes !!!");
      isLoading.value = false;
    }
  }
}
