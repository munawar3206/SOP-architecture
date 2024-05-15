import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:totalxproject/features/home/data/model/usermodel.dart';
import 'package:totalxproject/features/home/repo/i_getuser_impl.dart';
import 'package:totalxproject/general/core/enum.dart';
import 'package:totalxproject/general/service/showmessage.dart';

class GetUserProvider extends ChangeNotifier {
  AgeType selectvalue = AgeType.all;
  void changevalue(AgeType ageType) {
    selectvalue = ageType;
    notifyListeners();
  }

  GetUserProvider() {
    getUser(selectvalue);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getUser(selectvalue);
      }
    });
  }
  final ScrollController scrollController = ScrollController();

  GetUserRepository getUserRepository = GetUserRepository();
  List<UserModel> userlist = [];

  bool isMoreDataLoading = true;

  Future<void> getUser(AgeType ageType) async {
    final data = await getUserRepository.getUsers(ageType);
    data.fold((l) {
      if (l == "no_data") {
        log(l);
        isMoreDataLoading = false;
        notifyListeners();
      } else {
        showMessage(Colors.black, l);
      }
    }, (data) {
      if (data.length != 8) {
        isMoreDataLoading = false;
        log(isMoreDataLoading.toString());
      }

      userlist = [...userlist, ...data];
      log(userlist[0].age.toString());
      notifyListeners();
    });
  }

  void adduserlocal(UserModel userModel) {
    userlist.insert(0, userModel);
    notifyListeners();
  }

  void clearData() {
    getUserRepository.lastDocs = null;
    isMoreDataLoading = true;
    userlist.clear();
    notifyListeners();
  }
}
