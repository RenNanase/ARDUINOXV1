import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp2/component/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // User
  final currentUser = FirebaseAuth.instance.currentUser!;

  // All users
  final userCollection = FirebaseFirestore.instance.collection("Users");

  // Edit field
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.pink[50],
        title: Text(
          "Edit $field",
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: TextStyle(color: Colors.black54),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          // Cancel button
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.black54),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          // Save button
          TextButton(
            child: Text(
              'Save',
              style: TextStyle(color: Colors.black54),
            ),
            onPressed: () => Navigator.of(context).pop(newValue),
          ),
        ],
      ),
    );

    // Update in Firestore
    if (newValue.trim().isNotEmpty) {
      // Only update if there's something in the text
      await userCollection.doc(currentUser.uid).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        title: const Text("Profile Page"),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          // Get user data
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>? ?? {};
            return ListView(
              children: [
                const SizedBox(height: 50),

                // Profile pic || can change to image
                const Icon(
                  Icons.person,
                  size: 100,
                ),
                const SizedBox(height: 50),

                // User email
                Text(
                  currentUser.email!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 50),

                // User details
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    'My Details',
                    style: TextStyle(
                        color: Colors.grey[700]
                    ),
                  ),
                ),
                // Username
                MyTextBox(
                  text: userData['username'] ?? 'whats your username?',
                  sectionName: 'Username',
                  onPressed: () => editField('username'),
                ),
                const SizedBox(height: 10),

                // Bio
                MyTextBox(
                  text: userData['bio'] ?? 'whats your bio?',
                  sectionName: 'Bio',
                  onPressed: () => editField('bio'),
                ),
                const SizedBox(height: 50),

                // User details
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    'My Quiz Score',
                    style: TextStyle(
                        color: Colors.grey[700]
                    ),
                  ),
                ),

                // Quiz Score
                MyTextBox(
                  text: userData['Basic Arduino']?.toString() ?? 'No quiz score yet',
                  sectionName: 'Basic Arduino',
                  onPressed: () {}, // No edit functionality for quiz score
                ),
                const SizedBox(height: 10),
                MyTextBox(
                  text: userData['Get To Know Tinkercad']?.toString() ?? 'No quiz score yet',
                  sectionName: 'Get To Know Tinkercad',
                  onPressed: () {}, // No edit functionality for quiz score
                ),
                const SizedBox(height: 10),
                MyTextBox(
                  text: userData['Arduino Syntax']?.toString() ?? 'No quiz score yet',
                  sectionName: 'Arduino Syntax',
                  onPressed: () {}, // No edit functionality for quiz score
                ),
                const SizedBox(height: 10),
                MyTextBox(
                  text: userData['Arduino I/O']?.toString() ?? 'No quiz score yet',
                  sectionName: 'Arduino I/O',
                  onPressed: () {}, // No edit functionality for quiz score
                ),
                const SizedBox(height: 10),


              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
