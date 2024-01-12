import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final keyController = TextEditingController();
  final valueController = TextEditingController();

  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('movie');

  List<Map<String, String>> _movies = [];

  @override
  void initState() {
    super.initState();
    // Listen for changes in the database
    _databaseReference.onValue.listen((event) {
      setState(() {
        _movies.clear();
        if (event.snapshot.value != null) {
          Map<dynamic, dynamic>? data =
              event.snapshot.value as Map<dynamic, dynamic>?;
          data?.forEach((key, value) {
            // Handle the additional layer with the key "title"
            if (value != null && value is Map && value.containsKey('title')) {
              _movies.add({key: value['title']});
            }
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        title: Center(
          child: Text(
            "CRUD Data",
            style: TextStyle(
              fontFamily: "Poppins-Medium",
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // key text field
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
                    controller: keyController,
                    decoration: InputDecoration(
                      hintText: "Key",
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ),
            ),

            // value text field
            SizedBox(height: 20),
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
                    controller: valueController,
                    decoration: InputDecoration(
                      hintText: "Value",
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 30),
            Container(
              width: double.infinity,
              height: 54,
              decoration: BoxDecoration(
                color: Color(0xFF32449F),
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: () {
                  // Add data to the Firebase Realtime Database
                  String key = keyController.text.trim();
                  String value = valueController.text.trim();

                  if (key.isNotEmpty && value.isNotEmpty) {
                    _databaseReference.push().set({key : value});
                  }
                  keyController.clear();
                  valueController.clear();
                },
                child: Center(
                  child: Text(
                    "Add",
                    style: TextStyle(
                      fontFamily: "Poppins-SemiBold",
                      fontSize: 16,
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Movie List",
              style: TextStyle(
                fontFamily: "Poppins-Regular",
                fontSize: 16,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _movies.length,
                itemBuilder: (context, index) {
                  var movie = _movies[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      width: double.infinity,
                      height: 54,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 0,
                            blurRadius: 6,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Title : " + movie.values.first,
                              style: TextStyle(
                                fontFamily: "Poppins-Medium",
                                fontSize: 16,
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      _showUpdateDialog(context,
                                          movie.keys.first, movie.values.first);
                                    },
                                    child: Icon(
                                      CupertinoIcons.square_pencil_fill,
                                      color: Color(0xFF32449F),
                                      size: 24,
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  GestureDetector(
                                    onTap: () {
                                      // Delete data from Firebase Realtime Database
                                      String movieKey = movie.keys.first;
                                      _databaseReference
                                          .child(movieKey)
                                          .remove();
                                    },
                                    child: Icon(
                                      CupertinoIcons.trash_circle_fill,
                                      color: Color(0xFF32449F),
                                      size: 26,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showUpdateDialog(
    BuildContext context, String movieKey, String currentTitle) {
      TextEditingController valueController = TextEditingController();
        final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('movie');
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Update Movie"),
        content: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height *
                0.2,
            child: Column(
              children: [
                Text("Current Title: $currentTitle"),
                TextField(
                  controller: valueController,
                  decoration: InputDecoration(
                    hintText: "New Title",
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // Update data in Firebase Realtime Database
              String newValue = valueController.text.trim();
              if (newValue.isNotEmpty) {
                _databaseReference.child(movieKey).update({'title': newValue});
                Navigator.pop(context); // Close the dialog
              }
            },
            child: Text("Update"),
          ),
        ],
      );
    },
  );
}
