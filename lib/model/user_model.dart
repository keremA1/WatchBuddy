import 'package:firebase_auth/firebase_auth.dart';

class UserModel {

  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  String? address;
  String? postcode;
  String? contactNo;
  String? emergencyC;
  String? currentEm;
  String? sightLevel;


  UserModel ({
    this.uid,
    this.email,
    this.firstName,
    this.lastName,
    this.address,
    this.postcode,
    this.contactNo,
    this.emergencyC,
    this.currentEm,
    this.sightLevel});

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      address: map['address'],
      postcode: map['postcode'],
      contactNo: map['contact number'],
      emergencyC: map['emergency contact number'],
      currentEm: map['current employment'],
      sightLevel: map['sight level']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'postcode': postcode,
      'contact number': contactNo,
      'emergency contact number': emergencyC,
      'current employment': currentEm,
      'sight level': sightLevel
    };
  }
}