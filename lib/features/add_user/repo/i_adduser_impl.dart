import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:totalxproject/features/home/data/model/usermodel.dart';

class AddUserRepository {
  factory AddUserRepository() {
    return AddUserRepository._();
  }
  AddUserRepository._();
  final CollectionReference firestore =
      FirebaseFirestore.instance.collection('users');

  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final firebaseAuth = FirebaseAuth.instance;
  Future<Either<String, String>> addUsers(UserModel user) async {
    try {
      final id = firestore.doc().id;

      await firestore.doc(id).set(user.copyWith(docId: id).toMap());
      return right("Added Successfully");
    } catch (e) {
      log("Error occured : $e");
      return left("Error Occured");
    }
  }

  Future<String> getUserProfilePicture(File file) async {
    String fileName = DateTime.now().microsecondsSinceEpoch.toString();
    final ref = firebaseStorage.ref().child('profile_images/$fileName');
    await ref.putFile(File(file.path));
    return await ref.getDownloadURL();
  }
}
