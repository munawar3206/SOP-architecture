import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:totalxproject/features/home/presentation/view/home_screen.dart';
import 'package:totalxproject/features/otp/presentation/provider/otp_screen_provider.dart';
import 'package:totalxproject/general/images/appimages.dart';

class OtpScreen extends StatelessWidget {
  final String verificationid;
  final String phoneNumberController;

  OtpScreen({
    super.key,
    required this.verificationid,
    required this.phoneNumberController,
  });

  @override
  Widget build(BuildContext context) {
    final otpProvider = Provider.of<OtpProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          Appimages.otpimages,
                          height: 100,
                        ),
                        const Text(
                          "OTP Verification",
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            'Enter the verification code we just sent to your number : ${phoneNumberController}',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Pinput(
                            controller: otpProvider.otpControllers,
                            length: 6,
                            defaultPinTheme: PinTheme(
                                width: 55,
                                height: 55,
                                textStyle: const TextStyle(
                                    fontSize: 22, color: Colors.red),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.grey, width: 1))),
                            focusedPinTheme: PinTheme(
                                width: 55,
                                height: 55,
                                textStyle: const TextStyle(
                                    fontSize: 22, color: Colors.red),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black))),
                          ),
                        ),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: List.generate(
                        //     6,
                        //     (index) => SizedBox(
                        //       width: 50,
                        //       height: 50,
                        //       child: Padding(
                        //         padding:
                        //             const EdgeInsets.only(left: 5, right: 5),
                        //         child: TextField(
                        //           controller: otpProvider.otpControllers[index],
                        //           focusNode: otpProvider.focusNodes[index],
                        //           keyboardType: TextInputType.number,
                        //           textAlign: TextAlign.center,
                        //           style: const TextStyle(
                        //             color: Colors.red,
                        //             fontWeight: FontWeight.bold,
                        //             fontSize: 18,
                        //           ),
                        //           maxLength: 1,
                        //           onChanged: (value) {
                        //             if (value.isNotEmpty) {
                        //               if (index < 5) {
                        //                 otpProvider.focusNodes[index].unfocus();
                        //                 FocusScope.of(context).requestFocus(
                        //                     otpProvider.focusNodes[index + 1]);
                        //               } else {
                        //                 otpProvider.focusNodes[index].unfocus();
                        //               }
                        //             }
                        //           },
                        //           decoration: InputDecoration(
                        //             counterText: '',
                        //             border: OutlineInputBorder(
                        //               borderRadius: BorderRadius.circular(8),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't get OTP? ",
                              style: TextStyle(
                                letterSpacing: 1,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Resend",
                                style: TextStyle(color: Colors.blue),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: MaterialButton(
                              onPressed: () async {
                               await otpProvider.getotp(verificationid);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>const HomePage(),
                                    ));
                                
                              },
                              child: const Text(
                                "Verify",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
