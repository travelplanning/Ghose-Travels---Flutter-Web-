import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ghose_travels/src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyCffnCPleUH8kxHc4ZZVXayywsEo8lw6-Y',
      appId: '1:52934335830:android:b4ba4d3c36d6bfa780caf7',
      messagingSenderId: '52934335830',
      projectId: 'ghose-travels-beta',
      storageBucket: 'ghose-travels-beta.appspot.com',
    ),
  );
  runApp(App());
}
