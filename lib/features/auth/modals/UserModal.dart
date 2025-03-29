import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String userLanguagePreference;
  final Timestamp? createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.userLanguagePreference,
    this.createdAt,
  });

  /// Convert UserModel to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'userLanguagePreference': userLanguagePreference,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  /// Convert Firestore document to UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      userLanguagePreference: json['userLanguagePreference'] ?? 'en',
      createdAt: json['createdAt'],
    );
  }
}
