import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp2/arduino_notes.dart';
import 'package:fyp2/auth/main_page.dart';
import 'package:fyp2/component/text_field.dart';
import 'package:fyp2/drawer.dart';
import 'package:fyp2/profile_page.dart';
import 'package:fyp2/quiz_page.dart';
import 'package:fyp2/screens/mini_project.dart';
import 'package:fyp2/tinkercad_notes.dart';
import 'package:fyp2/video_tutorial.dart';
import 'package:fyp2/wall_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    createUserDocument();
  }

  Future<void> createUserDocument() async {
    final userDoc = FirebaseFirestore.instance.collection("Users").doc(currentUser.uid);
    final userSnapshot = await userDoc.get();

    if (!userSnapshot.exists) {
      await userDoc.set({
        'email': currentUser.email,
        'username': 'New User',
        'bio': 'This is my bio',
      });
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  MainPage()),
    );
  }

  void postMessage() async {
    if (textController.text.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentUser.uid)
          .collection("Posts")
          .add({
        'UserEmail': currentUser.email,
        'Message': textController.text,
        'TimeStamp': Timestamp.now(),
      });
      textController.clear();
    }
  }

  void deleteMessage(DocumentSnapshot post) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser.uid)
        .collection("Posts")
        .doc(post.id)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text("A R D U I N O X"),
        centerTitle: true,
        backgroundColor: Colors.pink[100],
      ),
      drawer: MyDrawer(
        onProfileTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfilePage()),
          );
        },
        onArduinoNotesTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ArduinoNotes()),
          );
        },
        onTinkercadNotesTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TinkercadNotes()),
          );
        },
        onMiniProjectTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MiniProject()),
          );
        },
        onQuizPageTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const QuizPage()),
          );
        },
        onVideoTutorialTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const VideoTutorial()),
          );
        },
        onSignOut: signOut,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc(currentUser.uid)
                    .collection("Posts")
                    .orderBy("TimeStamp", descending: true)
                    .limit(20)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No posts available.'));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final post = snapshot.data!.docs[index];
                      return WallPost(
                        message: post['Message'],
                        user: post['UserEmail'],
                        onDelete: () => deleteMessage(post),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      controller: textController,
                      hintText: 'Write something on the wall',
                      obscureText: false,
                    ),
                  ),
                  IconButton(
                    onPressed: postMessage,
                    icon: const Icon(Icons.arrow_circle_up),
                  ),
                ],
              ),
            ),
            Text("Logged in as: ${currentUser.email}"),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
