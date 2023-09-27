import 'package:bloodapp/add.dart';
import 'package:bloodapp/home.dart';
import 'package:bloodapp/update.dart';
import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => home(),
      '/add': (context) => addUser(),
      '/update': (context) => updateDonor()
    },
    initialRoute: '/',
  ));
}