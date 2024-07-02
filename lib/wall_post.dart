import 'package:flutter/material.dart';

class WallPost extends StatelessWidget {
  final String message;
  final String user;
  final VoidCallback onDelete;

  const WallPost({
    Key? key,
    required this.message,
    required this.user,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          // PROFILE PICTURE
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.pink[50],
            ),
            padding: EdgeInsets.all(10),
            child: Icon(Icons.person),
          ),

          // MESSAGE AND USER EMAIL
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user,
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(message),
              ],
            ),
          ),

          // DELETE BUTTON
          IconButton(
            onPressed: onDelete,
            icon: Icon(Icons.delete_outline),
            color: Colors.black54,
          ),
        ],
      ),
    );
  }
}
