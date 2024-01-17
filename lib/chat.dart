import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String username;
  const ChatScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back)),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              // backgroundImage: NetworkImage(
              //     "https://images.unsplash.com/photo-1632836928570-4b7b9b5b5b0f?ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzNnx8fGVufDB8fHx8&ixlib=rb-1.2.1&w=1000&q=80"),
            ),
            SizedBox(
              width: 10,
            ),
            Text(username),
          ],
        ),
        actions: [
          Icon(Icons.call),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.video_call_rounded, size: 30,),
          SizedBox(
            width: 10,
          ),
         
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              padding: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width*0.95,
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3), // Shadow color
                  spreadRadius: 2, // Spread radius
                  blurRadius: 7, // Blur radius
                  offset: Offset(1, 1), // Offset in the x, y direction
                ),
              ],
              ),
              child: Row(
                children: [
                  Icon(Icons.emoji_emotions_outlined),
                  Expanded(child: TextField()),
                  Icon(Icons.camera_alt_outlined),
                  Icon(Icons.file_present_outlined),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
