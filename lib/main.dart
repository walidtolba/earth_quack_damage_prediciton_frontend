import 'package:earth_quick_damage_prediction_frontend/screens/earthquake_damage_prediction_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Earthquake',
      theme: ThemeData.dark(),
      home: const EarthQuakeDamagePredictionScreen(),
    );
  }
}

