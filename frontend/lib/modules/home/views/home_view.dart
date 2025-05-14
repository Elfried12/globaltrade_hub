import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import '../widgets/home_header.dart';
import '../widgets/home_features.dart';
import '../widgets/home_stats.dart';
import '../widgets/home_testimonials.dart';
import '../widgets/home_loader.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final AnimationController _backgroundController;
  late final AnimationController _navbarController;
  late final AnimationController _loaderController;
  bool _showFloatingNav = false;
  bool _loading = true;

  final List<GlobalKey> _sectionKeys = List.generate(5, (_) => GlobalKey());
  final List<String> _navItems = [
    'Accueil',
    'Fonctionnalités',
    'Statistiques',
    'Témoignages',
    'Contact',
  ];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _setupScrollListener();
    _startInitialAnimation();
  }

  void _initializeControllers() {
    _scrollController = ScrollController();

    _backgroundController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _navbarController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _loaderController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      final showFloatingNav = _scrollController.offset > 100;
      if (showFloatingNav != _showFloatingNav) {
        setState(() => _showFloatingNav = showFloatingNav);
        if (showFloatingNav) {
          _navbarController.forward();
        } else {
          _navbarController.reverse();
        }
      }
      _checkSectionVisibility();
    });
  }

  void _startInitialAnimation() {
    _loaderController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() => _loading = false);
      });
    });
  }

  void _checkSectionVisibility() {
    for (final key in _sectionKeys) {
      final renderObject = key.currentContext?.findRenderObject();
      if (renderObject != null && renderObject is RenderBox) {
        final position = renderObject.localToGlobal(Offset.zero);
        final size = renderObject.size;
        final screenHeight = MediaQuery.of(context).size.height;

        final visibleTop = position.dy;
        final visibleBottom = position.dy + size.height;
        final visible = visibleTop < screenHeight && visibleBottom > 0;

        if (visible) {
          // Implement section-specific animations here
        }
      }
    }
  }

  @override
  void dispose() {
    _loaderController.dispose();
    _scrollController.dispose();
    _backgroundController.dispose();
    _navbarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return HomeLoader(controller: _loaderController);
    }

    return Scaffold(
      body: Stack(
        children: [
          // Animated Background
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _backgroundController,
              builder: (context, child) {
                return CustomPaint(
                  painter: _BackgroundPainter(
                    animation: _backgroundController.value,
                  ),
                );
              },
            ),
          ),

          // Main Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                _buildAnimatedSection(
                  key: _sectionKeys[0],
                  child: const HomeHeader(),
                ),
                _buildAnimatedSection(
                  key: _sectionKeys[1],
                  child: const HomeFeatures(),
                ),
                _buildAnimatedSection(
                  key: _sectionKeys[2],
                  child: const HomeStats(),
                ),
                _buildAnimatedSection(
                  key: _sectionKeys[3],
                  child: const HomeTestimonials(),
                ),
                _buildAnimatedSection(
                  key: _sectionKeys[4],
                  child: _buildFooter(),
                ),
              ],
            ),
          ),

          // Floating Navigation Bar
          AnimatedBuilder(
            animation: _navbarController,
            builder: (context, child) {
              return Positioned(
                top: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: Transform.translate(
                    offset: Offset(0, -100 * (1 - _navbarController.value)),
                    child: Opacity(
                      opacity: _navbarController.value,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1F2E).withOpacity(0.9),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: const Color(0xFF6C63FF).withOpacity(0.3),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6C63FF).withOpacity(0.2),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children:
                              _navItems.map((item) => _buildNavItem(item)).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildNavItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            final index = _navItems.indexOf(title);
            if (index >= 0 && index < _sectionKeys.length) {
              final context = _sectionKeys[index].currentContext;
              if (context != null) {
                Scrollable.ensureVisible(
                  context,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutCubic,
                );
              }
            }
          },
          child: Text(
            title,
            style: GoogleFonts.orbitron(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return AnimatedOpacity(
      opacity: _showFloatingNav ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutCubic,
          );
        },
        backgroundColor: const Color(0xFF1A1F2E),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                const Color(0xFF6C63FF),
                const Color(0xFF00FFFF),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Icon(
            Icons.keyboard_arrow_up,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0F1E),
        image: DecorationImage(
          image: const AssetImage('assets/images/grid_pattern.jpg'),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/gthint.png',
                      height: 40,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Révolutionnez votre commerce international avec la puissance de l\'IA et de la blockchain.',
                      style: GoogleFonts.spaceMono(
                        fontSize: 14,
                        color: Colors.white70,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 80),
              _buildFooterLinks('Produit', [
                'Fonctionnalités',
                'Tarifs',
                'Cas d\'usage',
                'Sécurité',
              ]),
              const SizedBox(width: 80),
              _buildFooterLinks('Entreprise', [
                'À propos',
                'Carrières',
                'Blog',
                'Contact',
              ]),
              const SizedBox(width: 80),
              _buildFooterLinks('Ressources', [
                'Documentation',
                'Centre d\'aide',
                'API',
                'Status',
              ]),
            ],
          ),
          const SizedBox(height: 60),
          const Divider(color: Colors.white24),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '© 2025 GlobalTrade Hub. Tous droits réservés.',
                style: GoogleFonts.spaceMono(
                  fontSize: 14,
                  color: Colors.white60,
                ),
              ),
              Row(
                children: [
                  _buildSocialButton(Icons.facebook, () {}),
                  const SizedBox(width: 20),
                  _buildSocialButton(Icons.telegram, () {}),
                  const SizedBox(width: 20),
                  _buildSocialButton(Icons.link, () {}), // Changed to Icons.link as a fallback
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLinks(String title, List<String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.orbitron(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),
        ...links.map((link) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Text(
                  link,
                  style: GoogleFonts.spaceMono(
                    fontSize: 14,
                    color: Colors.white60,
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, VoidCallback onPressed) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF6C63FF).withOpacity(0.3),
              width: 2,
            ),
          ),
          child: Icon(
            icon,
            color: Colors.white60,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedSection({
    required GlobalKey key,
    required Widget child,
  }) {
    return AnimatedBuilder(
      animation: _scrollController,
      builder: (context, _) {
        final renderObject = key.currentContext?.findRenderObject();
        if (renderObject == null) {
          return SizedBox(key: key, child: child);
        }

        final RenderBox box = renderObject as RenderBox;
        final position = box.localToGlobal(Offset.zero);
        final size = box.size;
        final screenHeight = MediaQuery.of(context).size.height;

        // Calculate visibility percentage
        final visibleTop = position.dy;
        final visibleBottom = position.dy + size.height;
        final visible = visibleTop < screenHeight && visibleBottom > 0;

        return AnimatedOpacity(
          key: key,
          duration: const Duration(milliseconds: 800),
          opacity: visible ? 1.0 : 0.0,
          child: AnimatedSlide(
            duration: const Duration(milliseconds: 800),
            offset: visible ? Offset.zero : const Offset(0, 0.1),
            child: child,
          ),
        );
      },
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  final double animation;

  _BackgroundPainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          const Color(0xFF0A0F1E),
          const Color(0xFF1A1F2E),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Offset.zero & size);

    canvas.drawRect(Offset.zero & size, paint);

    // Draw animated grid pattern
    final gridPaint = Paint()
      ..color = const Color(0xFF6C63FF).withOpacity(0.05)
      ..strokeWidth = 1;

    const spacing = 50.0;
    final xCount = (size.width / spacing).ceil() + 1;
    final yCount = (size.height / spacing).ceil() + 1;

    for (var i = 0; i < xCount; i++) {
      for (var j = 0; j < yCount; j++) {
        final x = i * spacing + math.sin(animation * 2 * math.pi + j * 0.5) * 5;
        final y = j * spacing + math.cos(animation * 2 * math.pi + i * 0.5) * 5;
        canvas.drawCircle(Offset(x, y), 1, gridPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}