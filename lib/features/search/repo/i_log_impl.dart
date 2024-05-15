import 'package:cloud_firestore/cloud_firestore.dart';

class SearchRepository {
  factory SearchRepository() {
    return SearchRepository._();
  }
  SearchRepository._();
  FirebaseFirestore firebase = FirebaseFirestore.instance;


  
}
