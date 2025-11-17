import 'package:flutter/material.dart';

class AnimatedGear extends StatefulWidget {
  const AnimatedGear({super.key});

  @override
  State<AnimatedGear> createState() => _AnimatedGearState();
}

class _AnimatedGearState extends State<AnimatedGear>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 12), // rotation très lente
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: controller,
      child: Image.asset(
        'assets/images/gear.png',
        width: 120,
      ),
    );
  }
}
