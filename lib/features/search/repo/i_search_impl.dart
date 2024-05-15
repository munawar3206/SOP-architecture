import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:totalxproject/features/home/data/model/usermodel.dart';

class SearchRepository {
  factory SearchRepository() {
    return SearchRepository._();
  }
  SearchRepository._();
  FirebaseFirestore fire = FirebaseFirestore.instance;
  

  QueryDocumentSnapshot? lastDocs;
  Future<Either<String, List<UserModel>>> getSearchUsers(String search) async {
    try {
      QuerySnapshot<Map<String, dynamic>> ref  
         = (lastDocs == null)
            ? await fire
                .collection('users')
                .where("search",arrayContains: search.toLowerCase())
                .orderBy("createdAt", descending: true)
                .limit(8)
                .get()
            : await fire
                .collection('users')
                .where("search",arrayContains: search.toLowerCase())
                .orderBy("createdAt", descending: true)
                .startAfterDocument(lastDocs!)
                .limit(8)
                .get();
      if (ref.docs.isEmpty) {
        return left("no_data");
      } else {
        lastDocs = ref.docs.last;
        return right(ref.docs.map((e) => UserModel.fromMap(e.data())).toList());
      }
    } catch (e) {
      log(e.toString());
      return left("An error occured while geting users");
    }
  }
  
}
