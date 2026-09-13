import 'package:flutter/material.dart';
import 'screens/sign_in_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const FreshShareApp());
}

class FreshShareApp extends StatelessWidget {
  const FreshShareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FreshShare',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const SignInScreen(),
    );
  }
}
