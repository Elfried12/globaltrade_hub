import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeFeatures extends StatelessWidget {
  const HomeFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80.0 : 24.0,
        vertical: 80.0,
      ),
      color: const Color(0xFFF5F7FA), // Softer background
      child: Column(
        children: [
          Text(
            'Fonctionnalités Clés',
            style: GoogleFonts.montserrat(
              fontSize: isDesktop ? 42 : 32,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF6C63FF),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Découvrez les outils qui transforment votre commerce',
            style: GoogleFonts.montserrat(
              fontSize: isDesktop ? 18 : 16,
              color: const Color(0xFF6B7280),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 40,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: [
              _FeatureCard(
                title: 'Recherche Intelligente',
                description:
                    'Trouvez les meilleurs fournisseurs grâce à notre IA.',
                icon: Icons.search,
              ),
              _FeatureCard(
                title: 'Sécurité des Transactions',
                description:
                    'Protégez vos paiements avec des garanties certifiées.',
                icon: Icons.security,
              ),
              _FeatureCard(
                title: 'Livraison Rapide',
                description:
                    'Optimisez vos délais avec notre réseau logistique global.',
                icon: Icons.local_shipping,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const _FeatureCard({
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C63FF).withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 40, color: const Color(0xFF6C63FF)),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2D3748),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: const Color(0xFF6B7280),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}