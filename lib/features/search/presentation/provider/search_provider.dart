import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:totalxproject/features/home/data/model/usermodel.dart';
import 'package:totalxproject/features/search/repo/i_search_impl.dart';
import 'package:totalxproject/general/service/showmessage.dart';

class SearchProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();

  SearchProvider() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getSearchUsers(); 
      }
    });
  }
  final ScrollController scrollController = ScrollController();
  SearchRepository searchUserRepository = SearchRepository();
  List<UserModel> userlist = [];

  bool isMoreDataLoading = true;
  bool isLoading = false;

  Future<void> getSearchUsers() async {
    final data =
        await searchUserRepository.getSearchUsers(searchController.text.trim());
    data.fold((l) {
      if (l == "no_data") {
        log(l);
        isMoreDataLoading = false;
        isLoading = false;
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
      isLoading = false;
      log(userlist[0].age.toString());
      notifyListeners();
    });
  }

  void clearData() {
    searchUserRepository.lastDocs = null;
    isMoreDataLoading = true;
    userlist.clear();
    notifyListeners();
  }
}
