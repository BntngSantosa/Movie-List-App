import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final databaseReference =
      // ignore: deprecated_member_use
      FirebaseDatabase.instance.reference().child("movie"); // Updated reference
  final movieController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            // text field
            Container(
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 6,
                    offset: Offset(0, 0),
                  ),
                ],
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: TextField(
                    controller: movieController,
                    decoration: InputDecoration(
                      hintText: "Title",
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  // Ensure Firebase is initialized before using the database
                  if (Firebase.apps.isEmpty) {
                    Firebase.initializeApp();
                  }

                  databaseReference.push().set({
                    'title': movieController.text,
                  });

                  // Clear the text field after adding data
                  movieController.clear();
                },
                child: Text(
                  "Add",
                  style: TextStyle(
                    fontFamily: "Poppins-SemiBold",
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
