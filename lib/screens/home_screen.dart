import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controllers/add_notes_controller.dart';
import 'package:notes_app/screens/addnotes_screen.dart';
import 'package:notes_app/screens/eiditor_screen.dart';
import 'package:notes_app/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  List yourColorsList = [
    Colors.blue.shade200,
    Colors.green.shade200,
    Colors.brown.shade200,
    Colors.yellow.shade200,
    Colors.red.shade200,
    Colors.orange.shade200,
    Colors.purple.shade200,
  ];
  var addNoteController = Get.put(
    AddNoteController(),
  );

  @override
  Widget build(BuildContext context) {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        leadingWidth: 150,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: Text(
            "Notes",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade500,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => EiditorScreen());
                      },
                      child: Icon(
                        Icons.search_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade500,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        /// dialogue box
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: Colors.black,
                            actions: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: Icon(
                                      Icons.info_outline,
                                      color: Colors.white,
                                      size: 36,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Text(
                                      "Want to Logout ?",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            backgroundColor: Colors.red),
                                        onPressed: () async {
                                          await FirebaseAuth.instance
                                              .signOut()
                                              .then((_) {
                                            Get.to(() => LoginScreen());
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            "YES",
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            backgroundColor: Colors.green),
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            "No",
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      child: Icon(
                        Icons.logout_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        shape: CircleBorder(),
        onPressed: () {
          Get.to(
            () => AddnotesScreen(
              noteId: "",
              title: "",
              subtitle: "",
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("notes")
                //  .where("userId", isNotEqualTo: userId)
                .snapshots(),
            builder: (context, snapshot) {
              //waiting

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.hasError.toString());
              } else {
                var data = snapshot.data?.docs ?? [];
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var item = data[index];

                    return GestureDetector(
                      onTap: () {
                        if (userId == item["userId"]) {
                          Get.to(() => AddnotesScreen(
                                noteId: item["noteId"],
                                title: item["title"],
                                subtitle: item["subtitle"],
                              ));
                        } else {
                          print("Other user Id");
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 15, right: 15, left: 15),
                        decoration: BoxDecoration(
                          color: yourColorsList[index == 6 ? index : index],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 25),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(userId == item["userId"]
                                        ? Icons.person
                                        : Icons.group),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item["title"].toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          item["subtitle"].toString(),
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (userId == item["userId"]) {
                                    addNoteController
                                        .deleteNotes(item["noteId"]);
                                  } else {
                                    print("This notes is alresdy exists");
                                  }
                                },
                                icon: Icon(
                                  Icons.delete_forever_outlined,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}
