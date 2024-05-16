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
        getSearchUsers(); //search scroll
      }
    });
  }
  final ScrollController scrollController = ScrollController();
  SearchRepository searchUserRepository = SearchRepository();
  List<UserModel> userlist = []; //userlist

  bool isMoreDataLoading = true;
  bool isLoading = false;

  Future<void> getSearchUsers() async {
    isLoading = true;
    final data =
        await searchUserRepository.getSearchUsers(searchController.text.trim());
    data.fold((l) {
      if (l == "No user Found") {
        showMessage(l);
        log(l);
        isMoreDataLoading = false;
        notifyListeners();
      } else {}
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

  void clearData() {
    
    searchUserRepository.lastDocs = null;
    isMoreDataLoading = true;
    userlist.clear();
    notifyListeners();
  }
}
