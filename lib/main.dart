import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naapbook_practical/Constant/AppColors.dart';
import 'package:naapbook_practical/Pages/RegistrationPage.dart';

import 'Pages/LoginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'NaapBooks Practical Task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: green),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}


