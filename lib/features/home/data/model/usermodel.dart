

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final int age;
  final String image;
  final Timestamp? createdAt;
  final String? docId;

  UserModel({
    this.docId,
    this.createdAt,
    required this.name,
    required this.age,
    required this.image,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      age: map['age'] as int,
      image: map['image'] as String,
      createdAt: map['createdAt'] as Timestamp,
      docId: map['docId'] != null ? map['docId'] as String : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'age': age,
      'image': image,
      'createdAt': createdAt?? FieldValue.serverTimestamp(),
      'docId': docId,
    };
  }

  UserModel copyWith({
    String? name,
    int? age,
    String? image,
    String? docId,
  }) {
    return UserModel(
      name: name ?? this.name,
      age: age ?? this.age,
      image: image ?? this.image,
      docId: docId ?? this.docId,
    );
  }


}
