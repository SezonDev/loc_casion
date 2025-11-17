import 'package:flutter/material.dart';
import 'package:loc_casion/services/token_storage.dart';
import 'package:loc_casion/widgets/animated_gear.dart';
import 'package:loc_casion/widgets/app_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  @override
    void initState() {
    super.initState();
    _checkLogin();
    }

    Future<void> _checkLogin() async {
    await Future.delayed(const Duration(seconds: 1)); // pour l’animation

    final isLoggedIn = await TokenStorage.hasToken();

    if (!mounted) return;

    // Toujours aller sur HomeScreen mais en gardant l’info connexion
    Navigator.pushReplacementNamed(context, '/home');
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AnimatedGear(),
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/logo.png',
                width: 160,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
