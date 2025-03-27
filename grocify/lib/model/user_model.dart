import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String username;
  final String email;
  final String contactNumber;
  final String profilePictureURL;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.contactNumber,
    required this.profilePictureURL,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'contactNumber': contactNumber,
      'profilePictureURL': profilePictureURL,
    };
  }

  factory UserModel.fromMap(DocumentSnapshot doc) {
    if (!doc.exists) {
      throw StateError('Document does not exist');
    }

    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return UserModel(
      uid: data['uid'] ?? '',
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      contactNumber: data['contactNumber'] ?? '',
      profilePictureURL: data['profilePictureURL'] ?? '',
    );
  }
}
