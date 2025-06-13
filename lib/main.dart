import 'package:flashlight_app/splash_screen.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(const TorchApp());
}
class TorchApp extends StatelessWidget {
  const TorchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}