import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class HomeFeatures extends StatefulWidget {
  const HomeFeatures({super.key});

  @override
  State<HomeFeatures> createState() => _HomeFeaturesState();
}

class _HomeFeaturesState extends State<HomeFeatures>
    with TickerProviderStateMixin {
  late final AnimationController _glowController;
  late final AnimationController _slideController;
  final List<bool> _hoveredStates = List.generate(4, (_) => false);

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _glowController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 800;

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 80.0 : 24.0,
            vertical: 80.0,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF1A1F2E),
                const Color(0xFF0A0F1E),
              ],
            ),
            image: DecorationImage(
              image: const AssetImage('assets/images/grid_pattern.png'),
              fit: BoxFit.cover,
              opacity: 0.05,
              colorFilter: ColorFilter.mode(
                const Color(0xFF6C63FF).withOpacity(0.3),
                BlendMode.overlay,
              ),
            ),
          ),
          child: Column(
            children: [
              Text(
                'Pourquoi choisir GlobalTrade Hub ?',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2D3748),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    const Color(0xFF6C63FF),
                    const Color(0xFF00FFFF),
                  ],
                ).createShader(bounds),
                child: Text(
                  'Technologies Innovantes',
                  style: GoogleFonts.orbitron(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              Wrap(
                spacing: 40,
                runSpacing: 40,
                alignment: WrapAlignment.center,
                children: [
                  _buildFeatureCard(
                    'Fournisseurs Certifiés',
                    'Réseau exclusif de partenaires vérifiés avec technologie blockchain.',
                    'verified',
                    0,
                  ),
                  _buildFeatureCard(
                    'Smart Logistics',
                    'Système logistique intelligent avec tracking en temps réel.',
                    'rocket_launch',
                    1,
                  ),
                  _buildFeatureCard(
                    'IA Prédictive',
                    'Algorithmes avancés pour des recommandations ultra-précises.',
                    'psychology',
                    2,
                  ),
                  _buildFeatureCard(
                    'Sécurité Quantique',
                    'Protection de nouvelle génération pour vos transactions.',
                    'security',
                    3,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFeatureCard(String title, String description, String icon,
      int index, {String? title2, String? description2, List<Color>? gradient}) {
    return _FeatureCard(
      icon: IconData(int.parse('e${index + 1}1c', radix: 16),
          fontFamily: 'MaterialIcons'),
      title: title,
      description: description,
      gradient: gradient ?? const [Color(0xFF6C63FF), Color(0xFF00FFFF)],
    );
  }
}

class _FeatureCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final List<Color> gradient;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.gradient,
  });

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 280,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF6C63FF).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                widget.icon,
                color: const Color(0xFF6C63FF),
                size: 32,
              ),
            ),
            const SizedBox(height: 24),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  const Color(0xFF6C63FF),
                  const Color(0xFF00FFFF),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                widget.title,
                style: GoogleFonts.orbitron(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.description,
              style: GoogleFonts.spaceMono(
                fontSize: 16,
                color: Colors.white70,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}