import 'package:flutter/material.dart';
import 'package:fyp2/my_list.dart';



class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onQuizPageTap;
  final void Function()? onTinkercadNotesTap;
  final void Function()? onArduinoNotesTap;
  final void Function()? onMiniProjectTap;
  final void Function()? onVideoTutorialTap;
  final void Function()? onSignOut;

  const MyDrawer({super.key,
    required this.onProfileTap,
    required this.onQuizPageTap,
    required this.onTinkercadNotesTap,
    required this.onArduinoNotesTap,
    required this.onMiniProjectTap,
    required this.onVideoTutorialTap,
    required this. onSignOut


  });


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.pink[100],
        child:  Column (
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

      Column(children: [
        //header
        const DrawerHeader(
          child : Icon(
            Icons.person,
            color: Colors.white,
            size:100,

          ),

        ),

        //profile list tile
        MyListTile (
          icon: Icons.person,
          text : 'P R O F I L E',
          onTap: onProfileTap,
        ),

        //profile list tile
        MyListTile (
          icon: Icons.description,
          text : 'A R D U I N O   L E S S O N S',
          onTap: onArduinoNotesTap,
        ),

        //profile list tile
        MyListTile (
          icon: Icons.description,
          text : 'T I N K E R C A D   L E S S O N S',
          onTap: onTinkercadNotesTap,
        ),

        //mini project list tile
        MyListTile (
          icon: Icons.folder,
          text : 'M I N I   P R O J E C T S',
          onTap: onMiniProjectTap,
        ),

        //profile list tile
        MyListTile (
          icon: Icons.video_collection,
          text : 'V I D E O   T U T O R I A L',
          onTap: onVideoTutorialTap,
        ),

        //profile list tile
        MyListTile (
          icon: Icons.quiz,
          text : 'Q U I Z',
          onTap: onQuizPageTap,
        ),

      ],
      ),


      //logout list tile
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: MyListTile(
                icon: Icons.logout,
                text : 'L O G O U T',
                onTap: onSignOut,
              ),
            ),



      ],
    ),
    );

  }
}
