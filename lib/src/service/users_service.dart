import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersService {
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?>
      getAllUsers() async {
    try {
      var snapshot = await FirebaseFirestore.instance.collection("users").get();
      var data = snapshot.docs;
      return data;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
