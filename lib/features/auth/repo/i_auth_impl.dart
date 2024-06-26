import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import 'package:totalxproject/features/auth/presentation/view/otpscreen/otp_screen.dart';

class LoginRepository {
  factory LoginRepository() {
    return LoginRepository._();
  }
  LoginRepository._();
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  Future<void> submitPhoneNum(
      BuildContext context, TextEditingController phoneNumberController) async {
    String phoneNumber = phoneNumberController.text.trim();

    if (!phoneNumber.startsWith("+91")) {
      phoneNumber = "+91" + phoneNumber;
    }

    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) {
        log(e.message.toString());
      },
      codeSent: (String verificationId, forceResendingToken) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(
              verificationid: verificationId,
              phoneNumberController: phoneNumber,
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<Either<String, String>> submitotpnum(verificationid, otp) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationid,
        smsCode: otp,
      );
      await auth.signInWithCredential(credential);
      return right("SuccessFully Logged");
    } catch (e) {
      log(e.toString());
      return left("Failed");
    }
  }
}
