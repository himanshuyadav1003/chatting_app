import 'package:chatting_app/chat.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(),));
              },
              leading: CircleAvatar(
                radius: 30,
                // backgroundImage: NetworkImage(
                //     "https://images.unsplash.com/photo-1632836928570-4b7b9b5b5b0f?ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzNnx8fGVufDB8fHx8&ixlib=rb-1.2.1&w=1000&q=80"),
              ),
              title: Text("User 1"),
              subtitle: Text("Hello"),
              trailing: Text("10:00"),
            ),
            Divider(),
          ],
        ),
      ),
    );
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
