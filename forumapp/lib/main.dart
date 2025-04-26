import 'package:flutter/material.dart';
import 'package:forumapp/views/home.dart';
import 'package:forumapp/views/login_page.dart';
import 'package:get/get.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp( // <-- THIS
      debugShowCheckedModeBanner: false,
      title: 'Forum App',
      home: HomePage(), //home page ganti ke LoginPage() kalo mau login page
    );
  }
}
