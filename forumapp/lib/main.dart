import 'package:flutter/material.dart';
import 'package:forumapp/views/login_page.dart';
import 'package:get/get.dart';
import 'package:forumapp/constants/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChillNTalk',
      theme: AppTheme.lightTheme(),
      home: const LoginPage(), //kalo mau ke home page pencet tombol login
    );
  }
}
