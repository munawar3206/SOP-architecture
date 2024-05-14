import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalxproject/features/add_user/presentation/provider/add_user.dart';
import 'package:totalxproject/features/home/presentation/provider/get_user_provider.dart';
import 'package:totalxproject/features/home/presentation/view/home_screen.dart';
import 'package:totalxproject/features/login/presentation/provider/login_provider.dart';
import 'package:totalxproject/features/otp/presentation/provider/otp_screen_provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var auth = FirebaseAuth.instance;
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OtpProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddUserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetUserProvider(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: HomePage()
          //  auth.currentUser != null ? HomePage() : LoginScreen(),
          ),
    );
  }
}
