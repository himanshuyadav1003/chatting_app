import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

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
            Text("User 1"),
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
    );
  }
}
