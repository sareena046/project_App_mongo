// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/pagenew_accont/create_accont.dart';
import 'package:test/provider/user_provider.dart'; // ตรวจสอบให้แน่ใจว่า import path ถูกต้อง
import 'package:test/pagenew_account/create_account.dart'; // ตรวจสอบให้แน่ใจว่า import path ถูกต้อง

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: UserFormScreen(),
    );
  }
}
