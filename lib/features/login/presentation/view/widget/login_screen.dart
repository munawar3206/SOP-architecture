import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalxproject/features/login/presentation/provider/login_provider.dart';
import 'package:totalxproject/features/login/repo/i_log_impl.dart';
import 'package:totalxproject/general/images/appimages.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                Appimages.logImage,
                height: 100,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            const Text(
              "Enter your Phone Number",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: loginProvider.phoneNumberController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter phone number *"),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text.rich(TextSpan(
                text: "By Continuing, I agree to TotalX’s",
                style: TextStyle(fontWeight: FontWeight.w600),
                children: [
                  TextSpan(
                      text: "Terms and condition &privacy policy",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold))
                ])),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(20)),
              child: MaterialButton(
                onPressed: () {
                  loginProvider.submitlogin(context);
                },
                child: const Text(
                  "Get OTP",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
