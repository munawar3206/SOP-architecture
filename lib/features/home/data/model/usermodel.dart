

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final int age;
  final String image;
  final Timestamp? createdAt;
  final String? docId;
  final List search;

  UserModel({
    this.docId,
    this.createdAt,
    required this.name,
    required this.age,
    required this.image,
    required this.search,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      age: map['age'] as int,
      image: map['image'] as String,
      search: map['search'] as List,
      createdAt: map['createdAt'] as Timestamp,
      docId: map['docId'] != null ? map['docId'] as String : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'age': age,
      'image': image,
      'search': search,
      'createdAt': createdAt?? FieldValue.serverTimestamp(),
      'docId': docId,
    };
  }

  UserModel copyWith({
    String? name,
    int? age,
    String? image,
    List? search,
    String? docId,
  }) {
    return UserModel(
      name: name ?? this.name,
      age: age ?? this.age,
      image: image ?? this.image,
      search: search ?? this.search,
      docId: docId ?? this.docId,
    );
  }


}
