import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 800;

        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0A0F1E),
            image: DecorationImage(
              image: const AssetImage('assets/images/grid_pattern.png'),
              fit: BoxFit.cover,
              opacity: 0.1,
              colorFilter: ColorFilter.mode(
                const Color(0xFF6C63FF).withOpacity(0.3),
                BlendMode.overlay,
              ),
            ),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 80.0 : 24.0,
              vertical: isDesktop ? 80.0 : 40.0,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF0A0F1E),
                  const Color(0xFF0A0F1E).withOpacity(0.9),
                  const Color(0xFF0A0F1E).withOpacity(0.8),
                ],
              ),
            ),
            child: Stack(
              children: [
                // Animated background particles
                ...List.generate(20, (index) => _buildParticle(index)),

                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildLogo(),
                        if (isDesktop)
                          Row(
                            children: [
                              _buildNavButton(
                                  'Se connecter',
                                  onPressed: () =>
                                      Navigator.pushNamed(context, '/auth')),
                              const SizedBox(width: 16),
                              _buildGlowingButton(
                                  'Créer un compte',
                                  onPressed: () =>
                                      Navigator.pushNamed(context, '/register')),
                            ],
                          ),
                      ],
                    ),
                    const SizedBox(height: 80),
                    if (isDesktop)
                      Row(
                        children: [
                          Expanded(
                            child: _buildHeroContent(),
                          ),
                          const SizedBox(width: 40),
                          Expanded(
                            child: _buildHeroAnimation(),
                          ),
                        ],
                      )
                    else
                      _buildHeroContent(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildParticle(int index) {
    final random = math.Random(index);
    final size = random.nextDouble() * 4 + 1;
    final speed = random.nextDouble() * 20 + 10;
    final initialX = random.nextDouble() * 400;
    final initialY = random.nextDouble() * 800;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final value = _controller.value;
        return Positioned(
          left: initialX,
          top: initialY + (value * speed),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: 1 - value,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF6C63FF).withOpacity(0.6),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLogo() {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _isHovered ? const Color(0xFF1A1F2E) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/gthint.png', height: 40),
            const SizedBox(width: 12),
            Text(
              'GlobalTrade Hub',
              style: GoogleFonts.spaceMono(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(String text, {required VoidCallback onPressed}) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.spaceMono(fontSize: 16),
      ),
    );
  }

  Widget _buildGlowingButton(String text, {required VoidCallback onPressed}) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6C63FF)
                    .withOpacity(0.3 * _glowAnimation.value),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C63FF),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              text,
              style: GoogleFonts.spaceMono(fontSize: 16),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeroContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'La plateforme B2B qui révolutionne le commerce au Bénin',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            height: 1.2,
            color: const Color(0xFF2D3748),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Connectez-vous à un réseau de fournisseurs certifiés, gérez vos transactions en toute sécurité et développez votre activité.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            color: const Color(0xFF718096),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Démarrer maintenant'),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('En savoir plus'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeroAnimation() {
    return Image.network(
      'https://cdn.pixabay.com/photo/2018/09/20/11/07/network-3713851_1280.png',
      height: 400,
    );
  }
}