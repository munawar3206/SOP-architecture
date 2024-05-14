import 'package:flutter/material.dart';
import 'package:totalxproject/features/otp/repo/i_otp_impl.dart';

class OtpProvider extends ChangeNotifier {
  TextEditingController otpControllers = TextEditingController();
  OtpRepository otpRepository = OtpRepository();
  Future<void> getotp(verificationid) async {
    await otpRepository.submitotpnum(verificationid, otpControllers.text);
  }
}
