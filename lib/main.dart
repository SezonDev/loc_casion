import 'package:flutter/material.dart';
import 'package:loc_casion/screens/home_screen.dart';
import 'package:loc_casion/screens/profile_screen.dart';
import 'package:loc_casion/screens/add_item_screen.dart';
import 'package:loc_casion/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LocCasionApp());
}

class LocCasionApp extends StatelessWidget {
  const LocCasionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Loc-casion',
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/add-item': (context) => const AddItemScreen(),
      },
    );
  }
}
