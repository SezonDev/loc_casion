import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 🌄 BACKGROUND IMAGE
        Positioned.fill(
          child: Image.asset(
            "assets/backgrounds/gradient_hd.png", // <-- adapte le nom si besoin
            fit: BoxFit.cover,
          ),
        ),

        // 🌚 OVERLAY OBSCURCISSANT (optionnel)
        Container(
          color: Colors.black.withOpacity(0.35),
        ),

        // 🌟 CONTENU PRINCIPAL
        SafeArea(
          child: child,
        )
      ],
    );
  }
}
