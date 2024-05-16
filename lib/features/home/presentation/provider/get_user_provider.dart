import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:totalxproject/features/home/data/model/usermodel.dart';
import 'package:totalxproject/features/home/repo/i_getuser_impl.dart';
import 'package:totalxproject/general/core/enum.dart';
import 'package:totalxproject/general/service/showmessage.dart';

class GetUserProvider extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  GetUserRepository getUserRepository = GetUserRepository();
  List<UserModel> userlist = [];
  bool isMoreDataLoading = true;
  bool isLoading = false;
  // enum selected for age sort
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

  // get user in age wise & lazy loading too

  Future<void> getUser(AgeType ageType) async {
    isLoading = true;
    final data = await getUserRepository.getUsers(ageType);
    data.fold((l) {
      if (l == "No More data") {
        isMoreDataLoading = false;
        notifyListeners();
        showMessage(l);
        log(l);
      } else {
        isMoreDataLoading = false;
        notifyListeners();
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
    isLoading = false;
    notifyListeners();
  }

// store locally in list
  void adduserlocal(UserModel userModel) {
    userlist.insert(0, userModel);
    notifyListeners();
  }

// to clear previous data
  void clearData() {
    getUserRepository.lastDocs = null;
    isMoreDataLoading = true;
    userlist.clear();
    notifyListeners();
  }
}
