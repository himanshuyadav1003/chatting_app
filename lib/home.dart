import 'package:chatting_app/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   final FirebaseAuth _auth = FirebaseAuth.instance;
   Map<String, dynamic> userMap = {};

   String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

    getCurrentUserData() async {
    // Get the current user ID
    final currentUserID = FirebaseAuth.instance.currentUser!.uid;

    // Get the current user's data
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserID)
        .get();

    userMap = snapshot.data() as Map<String, dynamic>;
    print(snapshot.data());
  }


@override
  void initState() {
    getCurrentUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       
        // title: Text("Chatting App"),
        actions: [
          Icon(Icons.search),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      drawer: buildDrawer(context),
      body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        // Get the current user ID
        final currentUserID = _auth.currentUser?.uid;

        // Filter out the current user from the list
        final filteredUsers = snapshot.data!.docs
            .where((doc) => doc.id != currentUserID)
            .toList();

        return ListView.builder(
          itemCount: filteredUsers.length,
          itemBuilder: (context, index) {
            // Access the fields using the correct names
            final username = filteredUsers[index]['username'];
            final phoneNumber = filteredUsers[index]['phoneNumber'];
            final email = filteredUsers[index]['email'];
            final id = filteredUsers[index]['id'];
            final createdAt = filteredUsers[index]['created at'];

            // Build your list item here using the extracted data
            // Example: Text(username)
            return ListTile(
              onTap: () {

                      String roomId = chatRoomId(
                        FirebaseAuth.instance.currentUser!.uid,
                        id,
                      );


                Navigator.push(context, MaterialPageRoute(builder: (context) {
                   return Chatroom(
                    userData: userMap,
                      targetName: username,
                      targetId: id,
                    chatroomId: roomId,
                   );
                },));
              },
              leading: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200]
                ),
              ),
              title: Text(username),
              subtitle: Text('Hello'),
              trailing: Text("10:00"),
              // Add more widgets as needed
            );
            Divider();
          },
        );}
      // Container(
      //   height: MediaQuery.of(context).size.height,
      //   width: MediaQuery.of(context).size.width,
      //   child: Column(
      //     children: [
      //       ListTile(
      //         onTap: () {
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(),));
      //         },
      //         leading: CircleAvatar(
      //           radius: 30,
      //           // backgroundImage: NetworkImage(
      //           //     "https://images.unsplash.com/photo-1632836928570-4b7b9b5b5b0f?ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzNnx8fGVufDB8fHx8&ixlib=rb-1.2.1&w=1000&q=80"),
      //         ),
      //         title: Text("User 1"),
      //         subtitle: Text("Hello"),
      //         trailing: Text("10:00"),
      //       ),
      //       Divider(),
      //     ],
      //   ),
      // ),
    ));
  
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  // backgroundImage: NetworkImage(
                  //     "https://images.unsplash.com/photo-1632836928570-4b7b9b5b5b0f?ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzNnx8fGVufDB8fHx8&ixlib=rb-1.2.1&w=1000&q=80"),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("User 1"),
              ],
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(Icons.person),
            title: Text("Profile"),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(Icons.settings),
            title: Text("Settings"),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(Icons.logout),
            title: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
