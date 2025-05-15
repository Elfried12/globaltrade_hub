import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'dart:async';

class HomeTestimonials extends StatefulWidget {
  const HomeTestimonials({super.key});

  @override
  State<HomeTestimonials> createState() => _HomeTestimonialsState();
}

class _HomeTestimonialsState extends State<HomeTestimonials> with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _slideController;
  late AnimationController _cardAnimationController;
  int _currentPage = 0;
  bool _isHovering = false;
  Timer? _autoPlayTimer;

  final List<TestimonialData> testimonials = [
    TestimonialData(
      name: "Sophie Koudou",
      role: "Directrice des Opérations",
      company: "AfricaGrow Solutions",
      avatar: "https://i.pravatar.cc/150?img=1",
      text: "GlobalTrade Hub a transformé notre chaîne d'approvisionnement. La transparence et la sécurité des transactions nous ont permis de développer notre activité à l'international en toute confiance.",
      rating: 5,
      gradient: const [Color(0xFF6C63FF), Color(0xFF4834DF)],
    ),
    TestimonialData(
      name: "Jean-Marc Ahoussou",
      role: "Fondateur & CEO",
      company: "BeninTech Imports",
      avatar: "https://i.pravatar.cc/150?img=2",
      text: "L'intégration de l'IA dans la plateforme est révolutionnaire. Les recommandations de fournisseurs sont ultra-pertinentes et nous ont fait gagner un temps précieux.",
      rating: 5,
      gradient: const [Color(0xFF00FFFF), Color(0xFF6C63FF)],
    ),
    TestimonialData(
      name: "Marie Dossou",
      role: "Responsable Achats",
      company: "Cotonou Market Leaders",
      avatar: "https://i.pravatar.cc/150?img=3",
      text: "La qualité du support client est exceptionnelle. Chaque question trouve une réponse rapide et précise. GTH est devenu un partenaire incontournable de notre succès.",
      rating: 5,
      gradient: const [Color(0xFF4834DF), Color(0xFF00FFFF)],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _startAutoPlay();
  }

  void _initializeControllers() {
    _pageController = PageController(
      viewportFraction: 0.85,
      initialPage: _currentPage,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();

    _cardAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
  }

  void _startAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!_isHovering && mounted) {
        final nextPage = (_currentPage + 1) % testimonials.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _slideController.dispose();
    _cardAnimationController.dispose();
    _autoPlayTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 800;

        return Container(
          padding: EdgeInsets.symmetric(
            vertical: 80.0,
            horizontal: isDesktop ? 40.0 : 20.0,
          ),
          color: const Color(0xFFF5F7FA), // Softer background
          child: Column(
            children: [
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.2),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _slideController,
                  curve: Curves.easeOutCubic,
                )),
                child: FadeTransition(
                  opacity: _slideController,
                  child: Column(
                    children: [
                      Text(
                        'Ils nous font confiance',
                        style: GoogleFonts.montserrat(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2D3748),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Témoignages de nos partenaires',
                        style: GoogleFonts.montserrat(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF6C63FF),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 60),
              MouseRegion(
                onEnter: (_) => setState(() => _isHovering = true),
                onExit: (_) => setState(() => _isHovering = false),
                child: SizedBox(
                  height: 400,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                      _cardAnimationController.forward(from: 0.0);
                    },
                    itemCount: testimonials.length,
                    itemBuilder: (context, index) {
                      final scale = _currentPage == index ? 1.0 : 0.9;
                      return TweenAnimationBuilder(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic,
                        tween: Tween(begin: scale, end: scale),
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: _TestimonialCard(
                              data: testimonials[index],
                              isActive: _currentPage == index,
                              animation: _cardAnimationController,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < testimonials.length; i++)
                    GestureDetector(
                      onTap: () => _pageController.animateToPage(
                        i,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOutCubic,
                      ),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == i ? 32 : 12,
                        height: 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: _currentPage == i
                              ? const Color(0xFF6C63FF)
                              : const Color(0xFF6B7280),
                          boxShadow: _currentPage == i
                              ? [
                                  BoxShadow(
                                    color: const Color(0xFF6C63FF).withOpacity(0.3),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  )
                                ]
                              : null,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final TestimonialData data;
  final bool isActive;
  final AnimationController animation;

  const _TestimonialCard({
    required this.data,
    required this.isActive,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C63FF).withOpacity(isActive ? 0.3 : 0.1),
            blurRadius: 20,
            spreadRadius: isActive ? 5 : 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF6C63FF),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6C63FF).withOpacity(0.1),
                        blurRadius: 10,
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(data.avatar),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name,
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2D3748),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${data.role} - ${data.company}',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              '"${data.text}"',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                height: 1.6,
                color: const Color(0xFF2D3748),
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                ...List.generate(
                  5,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Icon(
                      Icons.star,
                      color: index < data.rating
                          ? const Color(0xFFFFD700)
                          : const Color(0xFF6B7280),
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TestimonialData {
  final String name;
  final String role;
  final String company;
  final String avatar;
  final String text;
  final int rating;
  final List<Color> gradient;

  TestimonialData({
    required this.name,
    required this.role,
    required this.company,
    required this.avatar,
    required this.text,
    required this.rating,
    required this.gradient,
  });
}