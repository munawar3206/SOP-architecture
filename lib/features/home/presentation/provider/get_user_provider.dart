import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:totalxproject/features/home/data/model/usermodel.dart';
import 'package:totalxproject/features/home/repo/i_getuser_impl.dart';
import 'package:totalxproject/general/service/showmessage.dart';

class GetUserProvider extends ChangeNotifier {
  GetUserProvider() {
    getUser();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getUser();
      }
    });
  }
  final ScrollController scrollController = ScrollController();

  GetUserRepository getUserRepository = GetUserRepository();
  List<UserModel> userlist = [];
  // List<UserModel> fetchalluser = [];
  bool isScroll = false;
  bool isMoreDataLoading = true;

  Future<void> getUser() async {
    final data = await getUserRepository.getUsers();
    data.fold((l) {
      if (l.isEmpty) {
        isMoreDataLoading = false;
        notifyListeners();
      } else {
        showMessage(Colors.black, l);
      }
    }, (data) {
      if (data.length != 8 && data.length != 5) {
        isMoreDataLoading = false;
        log(isMoreDataLoading.toString());
      }
      log(isMoreDataLoading.toString());
      userlist = [...userlist, ...data];
      notifyListeners();
    });
  }

  void adduserlocal(UserModel userModel) {
    userlist.insert(0, userModel);
    notifyListeners();
  }
}
