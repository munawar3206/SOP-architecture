
import 'package:flutter/material.dart';
import 'package:totalxproject/features/login/repo/i_log_impl.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController phoneNumberController = TextEditingController();
  LoginRepository loginRepository = LoginRepository();
  Future<void> submitlogin(BuildContext context) async {
    await loginRepository.submitPhoneNum(context, phoneNumberController);
  }
}
