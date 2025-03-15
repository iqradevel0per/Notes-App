// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controllers/add_notes_controller.dart';
import 'package:notes_app/custom/custom_textfield.dart';

class AddnotesScreen extends StatelessWidget {
  AddnotesScreen(
      {super.key,
      required this.noteId,
      required this.title,
      required this.subtitle});

  String noteId;
  String title;
  String subtitle;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var addNoteController = Get.put(
    AddNoteController(),
  );

  @override
  Widget build(BuildContext context) {
    //yahan py
    addNoteController.titleController.text = title;
    addNoteController.subtitleController.text = subtitle;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        leadingWidth: 59,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20, top: 7, bottom: 9),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade500,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 23,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    "Title",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: CustomTextfield(
                    controller: addNoteController.titleController,
                    validator: (newValue) {
                      if (newValue == null || newValue.isEmpty) {
                        return "Please enter your title ";
                      } else {
                        return null;
                      }
                    },
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 17, horizontal: 15),
                    hintText: "Type Title",
                    hintStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                    fillColor: Colors.grey.shade300,
                    filled: true,
                    //suffixIcon: Icon(
                    //  Icons.cancel,
                    //  color: Colors.white,
                    // ),

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none),
                    cursorColor: Colors.grey.shade700,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    "Subtitle",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: CustomTextfield(
                    controller: addNoteController.subtitleController,
                    validator: (newValue) {
                      if (newValue == null || newValue.isEmpty) {
                        return "Please enter your subtitle ";
                      } else {
                        return null;
                      }
                    },
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 17, horizontal: 15),
                    hintText: "Type Subtitle",
                    hintStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                    fillColor: Colors.grey.shade300,
                    filled: true,
                    //suffixIcon: Icon(
                    //  Icons.cancel,
                    //  color: Colors.white,
                    // ),

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none),
                    cursorColor: Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        if (title.isEmpty) {
                          addNoteController.addNotes();
                        } else {
                          addNoteController.updateNotes(noteId, {
                            "timestamp": DateTime.now()
                                .microsecondsSinceEpoch
                                .toString(),
                            "title": addNoteController.titleController.text,
                            "subtitle":
                                addNoteController.subtitleController.text,
                          });
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 72, 0),
                        fixedSize: Size(double.maxFinite, 55)),
                    child: Obx(
                      () => addNoteController.isLoading.value
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              title.isEmpty ? "Save Notes" : "update Notes",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
