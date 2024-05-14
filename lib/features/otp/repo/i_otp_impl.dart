import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class OtpRepository {
  factory OtpRepository() {
    return OtpRepository._();
  }
  OtpRepository._();
  FirebaseFirestore firebase = FirebaseFirestore.instance;
    Future<void> submitotpnum(verificationid,otp) async {

    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
    
        verificationId:verificationid,
        smsCode: otp,
      );
      await auth.signInWithCredential(credential);
    } catch (e) {
      log(e.toString());
    }
  }

}
