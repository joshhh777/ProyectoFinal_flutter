import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/screens/Authentication/authentication.dart';
import 'package:proyecto_final/screens/Authentication/login.dart';
import 'package:proyecto_final/screens/homeScreens/home_screen.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    // ignore: unnecessary_null_comparison
    if (user != null) {
      return HomeScreen();
    } else{
      return Authentication();
    }
  }
}
  