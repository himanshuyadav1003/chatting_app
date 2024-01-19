// import 'package:camera/camera.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class ChatScreen extends StatefulWidget {
//   final String username;
//   // final String uid;

//   ChatScreen({Key? key, required this.username, }) : super(key: key);

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   TextEditingController controller = TextEditingController();
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//   late CollectionReference _chats;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCameraController();
//     _initializeFirestore();
//   }

//   Future<void> _initializeFirestore() async {
//     _chats = FirebaseFirestore.instance.collection('chats');
//   }

//   Future<void> _initializeCameraController() async {
//     final cameras = await availableCameras();
//     if (cameras.isNotEmpty) {
//       _controller = CameraController(cameras[0], ResolutionPreset.medium);
//       _initializeControllerFuture = _controller.initialize();
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Future<void> _openCamera() async {
//     try {
//       await _initializeControllerFuture;
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => Scaffold(
//             appBar: AppBar(title: Text('Camera Preview')),
//             body: CameraPreview(_controller),
//           ),
//         ),
//       );
//     } catch (e) {
//       print("Error opening camera: $e");
//     }
//   }

//   // Future<void> _sendMessage(String message) async {
//   //   final user = FirebaseAuth.instance.currentUser;

//   //   if (user != null) {
//   //     // String chatId = _getChatId(user.uid, widget.uid);
//   //     CollectionReference chatMessages = _chats.doc(chatId).collection('messages');

//   //     await chatMessages.add({
//   //       'text': message,
//   //       'senderUid': user.uid,
//   //       'timestamp': FieldValue.serverTimestamp(),
//   //     });
//   //   }
//   // }

//   String _getChatId(String uid1, String uid2) {
//     List<String> uids = [uid1, uid2];
//     uids.sort(); // Sort the UIDs to create a consistent chat ID
//     return '${uids[0]}_${uids[1]}';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(Icons.arrow_back),
//         ),
//         title: Row(
//           children: [
//             CircleAvatar(
//               radius: 20,
//               // Add your image URL or logic to display user image
//             ),
//             SizedBox(width: 10),
//             Text(widget.username),
//           ],
//         ),
//         actions: [
//           Icon(Icons.call),
//           SizedBox(width: 10),
//           Icon(
//             Icons.video_call_rounded,
//             size: 30,
//           ),
//           SizedBox(width: 10),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder(
//               stream: _chats.doc(_getChatId(FirebaseAuth.instance.currentUser!.uid, widget.uid)).collection('messages').orderBy('timestamp').snapshots(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }

//                 var messages =
//                     snapshot.data!.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

//                 return ListView.builder(
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     var message = messages[index];
//                     return _buildMessageWidget(message);
//                   },
//                 );
//               },
//             ),
//           ),
//           _buildInputWidget(),
//         ],
//       ),
//     );
//   }

//   Widget _buildMessageWidget(Map<String, dynamic> message) {
//     final currentUser = FirebaseAuth.instance.currentUser;
//     final isCurrentUser = currentUser?.uid == message['senderUid'];

//     return Align(
//       alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: isCurrentUser ? Colors.blue : Colors.grey,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Text(
//           message['text'],
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//     );
//   }

//   Widget _buildInputWidget() {
// return
//   }
// }

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Chatroom extends StatefulWidget {
  final Map<String, dynamic> userData;
  final String chatroomId;
  final String targetName, targetId;
  const Chatroom(
      {super.key,
      required this.chatroomId,
      required this.targetName,
      required this.targetId,
      required this.userData});

  @override
  State<Chatroom> createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  // Map<String, dynamic> userData = {};
  var controller = TextEditingController();
    late ScrollController scrollController;


  checkChatroomExist() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(widget.chatroomId)
        .get();
    if (snapshot.exists) {
      print("Chatroom exists");
    } else {
      Timer.periodic(Duration(seconds: 2), (timer) {
        if (widget.userData.isNotEmpty) {
          timer.cancel();
          createChatroom();
        }
      });
      // createChatroom();
    }
  }

  createChatroom() async {
    await FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(widget.chatroomId)
        .set({
      'participants': [widget.userData['id'], widget.targetId],
      'lastMessage': '',
      // 'lastMessageTimestamp': FieldValue.serverTimestamp(),
      'senderName': widget.userData['username'],
      'senderId': widget.userData['id'],
      'targetName': widget.targetName,
      'targetId': widget.targetId,
    });
  }

  // getCurrentUserData() async {
  //   // Get the current user ID
  //   final currentUserID = FirebaseAuth.instance.currentUser!.uid;

  //   // Get the current user's data
  //   final DocumentSnapshot snapshot = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(currentUserID)
  //       .get();

  //   userData = snapshot.data() as Map<String, dynamic>;
  //   print(snapshot.data());
  // }

  @override
  void initState() {
    // getCurrentUserData();
    scrollController = ScrollController();
  scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 300),
                  );
    checkChatroomExist();
    super.initState();
  }

    @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

      appBar: AppBar(
        title: Text(widget.targetName),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: Container(
                  // height: MediaQuery.of(context).size.height - 200,
                  child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('chatrooms')
                    .doc(widget.chatroomId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    final chatroomData = snapshot.data!.data() as Map;

                    if (chatroomData['messages'] != null) {
                      final messages = chatroomData['messages'];

                      // messages.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));

                      return ListView.builder(
                        controller: scrollController,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          return Align(
                            alignment:
                                message['senderId'] == widget.userData['id']
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                              // height: 60,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color:
                                    message['senderId'] == widget.userData['id']
                                        ? Colors.blue
                                        : Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                                // color: Colors.green,
                              ),
                              child: Text(message['msg']),
                            ),
                          );

                          // Card(
                          //   child: ListTile(
                          //     title: Text(message['msg']),
                          //     subtitle: Text(message['senderName']),
                          //   ),
                          // );
                        },
                      );
                    }
                  }
                  return Container();
                },
              )),
            ),
            // TextField(
            //   controller: controller,
            //   decoration: InputDecoration(
            //       hintText: "Type a message",
            //       border: InputBorder.none,
            //       suffix: IconButton(
            //         onPressed: () {
            //           sendMessage(text: controller.text);
            //         },
            //         icon: Icon(Icons.send),
            //       )),
            // ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              height: 60,
              padding: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        // await _openCamera();
                      },
                      child: Icon(Icons.camera_alt),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: "Type a message",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  if (controller.text.isEmpty) Icon(Icons.filter_sharp),
                  SizedBox(width: 10),
                  if (controller.text.isEmpty)
                    Icon(
                      Icons.mic,
                      size: 30,
                    ),
                  if (controller.text.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          sendMessage(text: controller.text);
                        },
                        child: Text("Send",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  sendMessage({text}) async {
    final currentUserID = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(widget.chatroomId)
        .update({
      'messages': FieldValue.arrayUnion([
        {
          'senderId': currentUserID,
          'msg': text,
          'senderName': widget.userData['username'],
          'timestamp': DateTime.now(),
          // 'timestamp' : FieldValue.serverTimestamp(),
        }
      ]),
      'lastMessage': text,
    }).then((value) {
      controller.clear();
    });
  }
}
