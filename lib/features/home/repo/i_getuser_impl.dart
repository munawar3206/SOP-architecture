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
      QuerySnapshot<Map<String,dynamic>> ref;
      if (ageType == AgeType.all) {
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
                .limit(5)
                .get();
      } else if (ageType == AgeType.elder) {
        ref = (lastDocs == null)
            ? await fire
                .collection('users')
                .orderBy("createdAt", descending: true)
                .where("age", isLessThan: 60)
                .limit(8)
                .get()
            : await fire
                .collection('users')
                .orderBy("createdAt", descending: true)
                .where("age", isLessThan: 60)
                .limit(8)
                .get();
        await fire
            .collection('users')
            .orderBy("createdAt", descending: true)
            .where("age", isLessThan: 60)
            .startAfterDocument(lastDocs!)
            .limit(5)
            .get();
      } else {
        ref = (lastDocs == null)
            ? await fire
                .collection('users')
                .orderBy("createdAt", descending: true)
                .where('age', isGreaterThanOrEqualTo: 60)
                .limit(8)
                .get()
            : await fire
                .collection('users')
                .orderBy("createdAt", descending: true)
                .where("age", isGreaterThanOrEqualTo: 60)
                .startAfterDocument(lastDocs!)
                .limit(5)
                .get();
      }
      if (ref.docs.isEmpty) {
        return left("no_data");
      } else {
        lastDocs = ref.docs.last;
        return right(ref.docs.map((e) => UserModel.fromMap(e.data())).toList());

      }
      // final ref = (lastDocs == null)
      //     ? await FirebaseFirestore.instance.collection("users").orderBy("createdAt",descending: true).limit(8).get()
      //     : await FirebaseFirestore.instance
      //         .collection("users")
      //         .orderBy("createdAt",descending: true)
      //         .startAfterDocument(lastDocs!)
      //         .limit(5)
      //         .get();
      // if (ref.docs.isEmpty) {
      //   return left("An error occured while geting users");
      // } else {
      //   lastDocs = ref.docs.last;
      //   return right(ref.docs.map((e) => UserModel.fromMap(e.data())).toList());
      // }
    } catch (e) {
      return left("An error occured while geting users");
    }
  }
}
