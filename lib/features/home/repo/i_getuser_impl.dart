import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:totalxproject/features/home/data/model/usermodel.dart';

class GetUserRepository {
  factory GetUserRepository() {
    return GetUserRepository._();
  }
  GetUserRepository._();
  final fire = FirebaseFirestore.instance;
  Future<List<QueryDocumentSnapshot>> getUsers() async {
    final data = await fire.collection("users").orderBy('name').limit(7).get();
    return data.docs;
  }

  Future<List<QueryDocumentSnapshot>> getMoreUsers(lastDocument) async {
    final data = await fire
        .collection("users")
        .orderBy('name')
        .startAfterDocument(lastDocument)
        .limit(2)
        .get();
    return data.docs;
  }

  // Future<List<UserModel>> getAllUsers() async {
  //   final data = await fire.collection("users").orderBy('name').get();

  //   final allData = data.docs
  //       .map((value) => UserModel.fromMap(value.data() as Map<String, dynamic>))
  //       .toList();
  //   return allData;
  // }
}
