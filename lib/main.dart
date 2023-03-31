import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ayurveda/screens/forgotpassword.dart';
import 'package:ayurveda/home.dart';
import 'package:ayurveda/screens/signup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  var user = FirebaseAuth.instance.currentUser;
  runApp(MyApp(user: user));
}

class MyApp extends StatelessWidget {
  final User? user;

  const MyApp({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.cyan, backgroundColor: Colors.white),
          primaryColor: Colors.cyan,
          textTheme: GoogleFonts.nunitoTextTheme()),
      initialRoute: '/',
      routes: {
        '/': (context) {
          if (user != null) {
            return const Home();
          } else {
            return const LoginPage();
          }
        },
        '/home': (context) => const Home(),
        '/signup': (context) => const SignupPage(),
        '/login': (context) => const LoginPage(),
        '/forgot-password': (context) => const ForgotPassword(),
      },
    );
  }
}
