import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ghose_travels/src/app.dart';

void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

   await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: 'AIzaSyA_A74W5ho3JmP_Nazqra1Krntq4-oaiHM',
      appId: '1:908223649178:android:75a73da6698e06a7781623',
      messagingSenderId: '908223649178',
      projectId: 'ghose-travels-ltd',
      storageBucket: 'ghose-travels-ltd.appspot.com',
    ),
  );
  runApp(App());
}

