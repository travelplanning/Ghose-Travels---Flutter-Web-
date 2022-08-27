
import 'package:cloud_firestore/cloud_firestore.dart';

class SliderModel {
  String ?id;
  String ?imageLink;
  Timestamp? time;

  SliderModel({this.id,   this.imageLink, this.time});

  SliderModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc['id'];
    
    imageLink = doc['campaignImage'];
    time = doc['time'];
  }
}
