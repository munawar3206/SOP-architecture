import 'package:flutter/material.dart';
import 'package:totalxproject/features/auth/repo/i_auth_impl.dart';

class AutheProvider extends ChangeNotifier {
  final TextEditingController phoneNumberController = TextEditingController();
  LoginRepository loginRepository = LoginRepository();
  Future<void> submitlogin(BuildContext context) async {
    await loginRepository.submitPhoneNum(context, phoneNumberController);
  }

  TextEditingController otpControllers = TextEditingController();

  Future<void> getotp(verificationid) async {
    await loginRepository.submitotpnum(verificationid, otpControllers.text);
  }
}
