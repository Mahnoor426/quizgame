import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizproject/signin.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //initializing firebase to link with firebase present in database.dart
  Future<FirebaseApp> _initializeFirebase() async{
    FirebaseApp firebaseApp= await Firebase.initializeApp();
    return firebaseApp;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          home: FutureBuilder(
            future: _initializeFirebase(),
            builder: (context, snapshot){
              if(snapshot.connectionState== ConnectionState.done){
                return LoginScreen(); // signin.dart ka widget hai
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
    );
  }
}


