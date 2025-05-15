import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCTA extends StatelessWidget {
  const HomeCTA({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80.0 : 24.0,
        vertical: 60.0,
      ),
      color: const Color(0xFF6C63FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main CTA Section
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Rejoignez GlobalTrade Hub Aujourd\'hui',
                        style: GoogleFonts.montserrat(
                          fontSize: isDesktop ? 36 : 28,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFFFFFF),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Inscrivez-vous pour débloquer toutes les opportunités commerciales.',
                        style: GoogleFonts.montserrat(
                          fontSize: isDesktop ? 18 : 16,
                          color: const Color(0xFFE5E7EB),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00FFFF),
                              foregroundColor: const Color(0xFF2D3748),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'S\'inscrire',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFFFFFFFF),
                            ),
                            child: Text(
                              'En savoir plus',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Color(0xFFE5E7EB), thickness: 1),
          const SizedBox(height: 40),
          // Footer Links and Info
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Company Info
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/images/gthint.png',
                                  height: 40),
                              const SizedBox(width: 12),
                              Text(
                                'GlobalTrade Hub',
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFFFFFFF),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Votre partenaire pour un commerce mondial simplifié et sécurisé.',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: const Color(0xFFE5E7EB),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Navigation Links
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Liens Utiles',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFFFFFFF),
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildFooterLink('Accueil'),
                          _buildFooterLink('Fonctionnalités'),
                          _buildFooterLink('Témoignages'),
                          _buildFooterLink('FAQ'),
                        ],
                      ),
                    ),
                    // Contact Info
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Contactez-nous',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFFFFFFF),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Email: support@globaltradehub.com',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: const Color(0xFFE5E7EB),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Téléphone: +1 234 567 890',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: const Color(0xFFE5E7EB),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Social Media
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Suivez-nous',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFFFFFFF),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.facebook,
                                    color: Color(0xFFE5E7EB)),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.language,
                                    color: Color(0xFFE5E7EB)),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.linked_camera,
                                    color: Color(0xFFE5E7EB)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Company Info
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/images/gthint.png',
                                height: 40),
                            const SizedBox(width: 12),
                            Text(
                              'GlobalTrade Hub',
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFFFFFFF),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Votre partenaire pour un commerce mondial simplifié et sécurisé.',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: const Color(0xFFE5E7EB),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Navigation Links
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Liens Utiles',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFFFFFFF),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildFooterLink('Accueil'),
                        _buildFooterLink('Fonctionnalités'),
                        _buildFooterLink('Témoignages'),
                        _buildFooterLink('FAQ'),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Contact Info
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contactez-nous',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFFFFFFF),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Email: support@globaltradehub.com',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: const Color(0xFFE5E7EB),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Téléphone: +1 234 567 890',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: const Color(0xFFE5E7EB),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Social Media
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Suivez-nous',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFFFFFFF),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.facebook,
                                  color: Color(0xFFE5E7EB)),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.language,
                                  color: Color(0xFFE5E7EB)),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.linked_camera,
                                  color: Color(0xFFE5E7EB)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
          const SizedBox(height: 40),
          Center(
            child: Text(
              '© 2025 GlobalTrade Hub. Tous droits réservés.',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                color: const Color(0xFFE5E7EB),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildFooterLink(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFFE5E7EB),
        padding: EdgeInsets.zero,
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        title,
        style: GoogleFonts.montserrat(
          fontSize: 14,
          color: const Color(0xFFE5E7EB),
        ),
      ),
    ),
  );
}