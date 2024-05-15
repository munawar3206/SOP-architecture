import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:totalxproject/features/home/data/model/usermodel.dart';

class SortRepository {
  factory SortRepository() {
    return SortRepository._();
  }
  SortRepository._();
  FirebaseFirestore firebase = FirebaseFirestore.instance;
// Greater Sort
  // QueryDocumentSnapshot? greaterthan;
  // Future<Either<String, List<UserModel>>> getgreater() async {
  //   try {
  //     final ref = (greaterthan == null)
  //         ? await FirebaseFirestore.instance
  //             .collection("users")
  //             .where('age', isGreaterThanOrEqualTo: 60)
  //             .orderBy("createdAt", descending: true)
  //             .limit(5)
  //             .get()
  //         : await FirebaseFirestore.instance
  //             .collection("users")
  //             .where('age', isGreaterThanOrEqualTo: 60)
  //             .orderBy("createdAt", descending: true)
  //             .startAfterDocument(greaterthan!)
  //             .limit(2)
  //             .get();
  //     if (ref.docs.isEmpty) {
  //       return left("An error found");
  //     } else {
  //       greaterthan = ref.docs.last;
  //       return right(ref.docs.map((e) => UserModel.fromMap(e.data())).toList());
  //     }
  //   } catch (e) {
  //     return left("An error occured while geting users");
  //   }
  // }
// Less than Sort

   
    







  // QueryDocumentSnapshot? getless;
  // Future<Either<String, List<UserModel>>> getlessthan() async {
  //   try {
  //     final ref = (getless == null)
  //         ? await FirebaseFirestore.instance
  //             .collection("users")
  //             .where('age', isLessThan: 60)
  //             .orderBy("createdAt", descending: true)
  //             .limit(5)
  //             .get()
  //         : await FirebaseFirestore.instance
  //             .collection("users")
  //             .where("age", isLessThan: 60)
  //             .orderBy("createdAt", descending: true)
  //             .limit(3)
  //             .startAfterDocument(getless!)
  //             .get();
  //     if (ref.docs.isEmpty) {
  //       return left("An error found");
  //     } else {
  //       getless = ref.docs.last;
  //       return right(ref.docs.map((e) => UserModel.fromMap(e.data())).toList());
  //     }
  //   } catch (e) {
  //     return left("An error occured while geting users");
  //   }
  // }

    Future<List<UserModel>> getlessthan() async {
    final data =
        await firebase.collection('users').where('age', isLessThan: 60).get();

    final userdata = data.docs.map((e) => UserModel.fromMap(e.data())).toList();
    return userdata;
  }

  Future<List<UserModel>> getgreater() async {
    final data = await firebase
        .collection('users')
        .where('age', isGreaterThanOrEqualTo: 60)
        .get();

    final userdata = data.docs.map((e) => UserModel.fromMap(e.data())).toList();
    return userdata;
  }
}
