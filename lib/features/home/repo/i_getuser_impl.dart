import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:totalxproject/features/home/data/model/usermodel.dart';
import 'package:totalxproject/general/core/enum.dart';

class GetUserRepository {
  factory GetUserRepository() {
    return GetUserRepository._();
  }
  GetUserRepository._();
  final fire = FirebaseFirestore.instance;

  QueryDocumentSnapshot? lastDocs;
  Future<Either<String, List<UserModel>>> getUsers(AgeType ageType) async {
    try {
      QuerySnapshot<Map<String, dynamic>> ref;
      if (ageType == AgeType.all) {
        // all data load
        ref = (lastDocs == null)
            ? await fire
                .collection('users')
                .orderBy("createdAt", descending: true)
                .limit(8)
                .get()
            : await fire
                .collection('users')
                .orderBy("createdAt", descending: true)
                .startAfterDocument(lastDocs!)
                .limit(8)
                .get();
      } else if (ageType == AgeType.younger) {
        //younger list load
        ref = (lastDocs == null)
            ? await fire
                .collection('users')
                .where("age", isLessThan: 60)
                .orderBy("age", descending: false)
                .limit(8)
                .get()
            : await fire
                .collection('users')
                .where("age", isLessThan: 60)
                .orderBy("age", descending: false)
                .startAfterDocument(lastDocs!)
                .limit(8)
                .get();
      } else {
        ref = (lastDocs == null) //elder load
            ? await fire
                .collection('users')
                .where("age", isGreaterThanOrEqualTo: 60)
                .orderBy("age", descending: true)
                .limit(8)
                .get()
            : await fire
                .collection('users')
                .where("age", isGreaterThanOrEqualTo: 60)
                .orderBy("age", descending: true)
                .startAfterDocument(lastDocs!)
                .limit(8)
                .get();
      }
      if (ref.docs.isEmpty) {
        return left("No More data");
      } else {
        lastDocs = ref.docs.last;
        return right(ref.docs.map((e) => UserModel.fromMap(e.data())).toList());
      }
    } catch (e) {
      log(e.toString());
      return left("An error occured while geting users");
    }
  }
  
//delete from firebase
  Future<Either<String, String>> deleteUser(String id) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(id).delete();

      return right("Delete Successfully");
    } catch (e) {
      log("Error deleting user: $e");
      return left("Failed!");
    }
  }
}
