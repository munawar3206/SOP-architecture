

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalxproject/features/add_user/presentation/provider/add_user_provider.dart';
import 'package:totalxproject/features/auth/presentation/view/loginscreen/login_screen.dart';
import 'package:totalxproject/features/home/presentation/provider/get_user_provider.dart';
import 'package:totalxproject/features/home/presentation/view/home_screen.dart';
import 'package:totalxproject/features/auth/presentation/provider/auth_provider.dart';

import 'package:totalxproject/features/search/presentation/provider/search_provider.dart';

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
          create: (context) => AutheProvider(),
        ),

        ChangeNotifierProvider(
          create: (context) => AddUserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetUserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(),
        ),

      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home:
          //  HomePage()
           auth.currentUser != null ? HomePage() : LoginScreen(),
          ),
    );
  }
}
