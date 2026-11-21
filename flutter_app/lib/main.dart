import 'package:flutter/material.dart';

void main() {
  runApp(const ShamDeliveryApp());
}

class ShamDeliveryApp extends StatelessWidget {
  const ShamDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سوق الشام',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(title: const Text('سوق الشام')),
          body: const Center(
            child: Text('منصة الشام للمواد الغذائية والوجبات السريعة'),
          ),
        ),
      ),
    );
  }
}
