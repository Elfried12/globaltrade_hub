import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'package:carousel_slider/carousel_slider.dart';

class HomeTestimonials extends StatefulWidget {
  const HomeTestimonials({super.key});

  @override
  State<HomeTestimonials> createState() => _HomeTestimonialsState();
}

class _HomeTestimonialsState extends State<HomeTestimonials>
    with TickerProviderStateMixin {
  late final AnimationController _glowController;
  late final AnimationController _slideController;
  final CarouselSliderController _carouselController = CarouselSliderController(); // Updated to CarouselSliderController
  int _currentIndex = 0;

  final List<Map<String, String>> _testimonials = [
    {
      'name': 'Sophie M.',
      'role': 'Directrice Commerciale',
      'company': 'AfricaStyle',
      'text':
          'GlobalTrade Hub a révolutionné notre approche des importations. La technologie blockchain nous assure une traçabilité parfaite.',
      'avatar': 'assets/images/avatar1.png',
    },
    {
      'name': 'Marc K.',
      'role': 'CEO',
      'company': 'BeninTech Solutions',
      'text':
          'L’IA prédictive nous permet d’anticiper les tendances du marché avec une précision impressionnante.',
      'avatar': 'assets/images/avatar2.png',
    },
    {
      'name': 'Aisha D.',
      'role': 'Responsable Logistique',
      'company': 'TransCargo Bénin',
      'text':
          'Le système de tracking en temps réel a transformé notre gestion logistique. Une vraie innovation.',
      'avatar': 'assets/images/avatar3.png',
    },
  ];

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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80),
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
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                const Color(0xFF6C63FF),
                const Color(0xFF00FFFF),
              ],
            ).createShader(bounds),
            child: Text(
              'Témoignages',
              style: GoogleFonts.orbitron(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 60),
          CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: _testimonials.length,
            options: CarouselOptions(
              height: 400,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              onPageChanged: (index, reason) {
                setState(() => _currentIndex = index);
              },
            ),
            itemBuilder: (context, index, realIndex) {
              return _buildTestimonialCard(
                _testimonials[index],
                index,
              );
            },
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _testimonials.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _carouselController.animateToPage(entry.key), // Updated to animateToPage
                child: Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == entry.key
                        ? const Color(0xFF6C63FF)
                        : Colors.white.withOpacity(0.2),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(Map<String, String> testimonial, int index) {
    return AnimatedBuilder(
      animation: Listenable.merge([_glowController, _slideController]),
      builder: (context, child) {
        final slideOffset = 1 -
            Curves.easeOutExpo.transform(
              math.min(1, _slideController.value * 3 - index * 0.4),
            );

        return Transform.translate(
          offset: Offset(0, 50 * slideOffset),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: _slideController.value,
            child: Container(
              width: 400,
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1F2E),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xFF6C63FF)
                      .withOpacity(_currentIndex == index ? 0.5 : 0.2),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6C63FF).withOpacity(
                      0.2 *
                          (_currentIndex == index ? 1 : 0.5) *
                          (1 + _glowController.value * 0.5),
                    ),
                    blurRadius: 20,
                    spreadRadius: _currentIndex == index ? 5 : 0,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF6C63FF),
                        width: 2,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundColor: Color(0xFF1A1F2E),
                      child: Icon(
                        Icons.person,
                        color: Color(0xFF6C63FF),
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    testimonial['text']!,
                    style: GoogleFonts.spaceMono(
                      fontSize: 16,
                      color: Colors.white70,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [
                        const Color(0xFF6C63FF),
                        const Color(0xFF00FFFF),
                      ],
                    ).createShader(bounds),
                    child: Text(
                      testimonial['name']!,
                      style: GoogleFonts.orbitron(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${testimonial['role']!} - ${testimonial['company']!}',
                    style: GoogleFonts.spaceMono(
                      fontSize: 14,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}