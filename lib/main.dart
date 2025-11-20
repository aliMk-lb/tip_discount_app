import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const TipDiscountApp());
}

class TipDiscountApp extends StatelessWidget {
  const TipDiscountApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tip & Discount Helper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
