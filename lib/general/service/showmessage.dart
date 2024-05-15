

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


void showMessage(Color color,String msg) {
//  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg),backgroundColor:color ,));

  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}
