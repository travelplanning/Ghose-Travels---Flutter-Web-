import 'package:cloud_firestore/cloud_firestore.dart';

class VehiclesModel {
  String? carId;
  String? brandId;
  String? carImage;
  String? carName;
  int? advancedPaymentAmount;
  int? carRent;
  String? modelYear;
  Timestamp? time;

  VehiclesModel({
    this.advancedPaymentAmount,
    this.brandId,
    this.carId,
    this.carImage,
    this.carName,
    this.carRent,
    this.modelYear,
    this.time,
  });

  VehiclesModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    advancedPaymentAmount = doc['advancedPaymentAmount'];
    brandId = doc['brandId'];
    carId = doc['carId'];
    carImage = doc['carImage'];
    carName = doc['carName'];
    carRent = doc['carRent'];
    modelYear = doc['modelYear'];

    time = doc['time'];
  }
}
