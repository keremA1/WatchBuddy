import 'package:firebase_auth/firebase_auth.dart';

class VolModel {

  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  String? address;
  String? postcode;
  String? contactNo;
  String? emergencyC;
  String? currentEm;
  String? prevEm;
  String? times;
  String? days;


  VolModel ({
    this.uid,
    this.email,
    this.firstName,
    this.lastName,
    this.address,
    this.postcode,
    this.contactNo,
    this.emergencyC,
    this.currentEm,
    this.prevEm,
    this.times,
    this.days});

  factory VolModel.fromMap(map) {
    return VolModel(
        uid: map['uid'],
        email: map['email'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        address: map['address'],
        postcode: map['postcode'],
        contactNo: map['contact number'],
        emergencyC: map['emergency contact number'],
        currentEm: map['current employment'],
        prevEm: map['previous employment'],
        times: map['times available'],
        days: map['days available']
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
      'previous employment': prevEm,
      'times available': times,
      'days available': days
    };
  }
}