import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeLoader extends StatelessWidget {
  final AnimationController controller;

  const HomeLoader({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6C63FF), Color(0xFF4834DF)],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie/hexagons_loader.json',
              controller: controller,
              height: 180,
            ),
            const SizedBox(height: 24),
            const Text(
              'GlobalTrade Hub',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}