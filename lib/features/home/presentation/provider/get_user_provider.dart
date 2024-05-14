import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:totalxproject/features/home/data/model/usermodel.dart';
import 'package:totalxproject/features/home/repo/i_getuser_impl.dart';

class GetUserProvider extends ChangeNotifier {
  GetUserProvider() {
    getUser();
    getfullUsers();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getfullUsers();
      }
    });
  }
  final ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  GetUserRepository getUserRepository = GetUserRepository();
  List<UserModel> userlist = [];
  List<UserModel> fetchalluser = [];
  // int selectedValue = 1;
  // bool isSorting = false;   
  var lastDocs;

  Future<void> getUser() async {
    final data = await getUserRepository.getUsers();
    lastDocs = data.last as QueryDocumentSnapshot<Object>?;
    userlist = data
        .map((e) => UserModel.fromMap(e.data() as Map<String, dynamic>))
        .toList();

    notifyListeners();
  }

  Future<void> getfullUsers() async {
    final data = await getUserRepository.getMoreUsers(lastDocs);
    lastDocs = data.last as QueryDocumentSnapshot<Object>?;
    await Future.delayed(Duration(seconds: 1));
    userlist.addAll(data
        .map((e) => UserModel.fromMap(e.data() as Map<String, dynamic>))
        .toList());
    notifyListeners();
  }
}
