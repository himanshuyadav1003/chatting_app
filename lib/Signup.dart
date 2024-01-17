import 'package:chatting_app/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController phonenumber = TextEditingController();

    final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _signUp(BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      String uid = userCredential.user!.uid;
       // Get the current server timestamp
    FieldValue serverTimestamp = FieldValue.serverTimestamp();
      // Store additional user information in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': username.text,
        'phoneNumber': phonenumber.text,
         'email': email.text,
         'id': uid,
         'created at':serverTimestamp
      });

      // Registration successful, you can now navigate to the home screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      // Handle other exceptions as needed
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              ShaderMask(
                shaderCallback: (rect) => LinearGradient(
                  colors: [
                    Colors.deepPurple,
                    Colors.deepPurpleAccent,
                  ],
                ).createShader(rect),
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Container(
                height: 60,
                padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: username,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Username",
                    prefixIcon: Icon(Icons.person_2_outlined),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                height: 60,
                padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Email",
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                height: 60,
                padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Password",
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                height: 60,
                padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: confirmpassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Confirm Password",
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                height: 60,
                padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: phonenumber,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Phone Number",
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              GestureDetector(
                onTap: () async{
                  _signUp(context);
                 
                },
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [
                        Colors.deepPurple,
                        Colors.deepPurpleAccent,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
