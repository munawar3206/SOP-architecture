import 'package:flutter/material.dart';
import 'package:totalxproject/features/home/data/model/usermodel.dart';
import 'package:totalxproject/features/sort/repo/i_log_impl.dart';

class SortProvider extends ChangeNotifier {
  List<UserModel> sortlist = [];
  String selectedvalue = "All";
  bool isSorting = false;
 final SortRepository sortrepository = SortRepository();

  void sortUser(String value) async {
      print("SortUser called with value: $value");
    selectedvalue = value;
    if (selectedvalue == "All") {
      isSorting = false;
    }  else if (selectedvalue == "Younger") {
      isSorting = true;
      sortlist = await sortrepository.getlessthan();
    }else if (selectedvalue == "Elder") {
      isSorting = true;
      sortlist = await sortrepository.getgreater();
      print("Sorting Elder");
    }
      print("Sortlist length: ${sortlist.length}");
    notifyListeners();
  }
}
