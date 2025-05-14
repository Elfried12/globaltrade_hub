import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCTA extends StatelessWidget {
  const HomeCTA({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF6C63FF), Color(0xFF4834DF)],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6C63FF).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Prêt à révolutionner votre business ?',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Rejoignez la première plateforme B2B du Bénin et développez votre activité en toute sécurité.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/register'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF6C63FF),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Démarrer maintenant'),
                    ),
                    const SizedBox(width: 16),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/auth'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 20,
                        ),
                      ),
                      child: const Text('Se connecter'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          Text(
            '© 2025 GlobalTrade Hub - Tous droits réservés',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: const Color(0xFF718096),
            ),
          ),
        ],
      ),
    );
  }
}