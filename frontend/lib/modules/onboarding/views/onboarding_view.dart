import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:carousel_slider/carousel_controller.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> with TickerProviderStateMixin {
  final CarouselSliderController _carouselController = CarouselSliderController();
  int _currentIndex = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  // Define onboarding pages with Lottie animations
  final List<Map<String, String>> _onboardingPages = [
    {
      'title': 'Connectez-vous au Commerce Mondial',
      'description': 'Accédez à un réseau mondial de partenaires B2B pour développer votre activité.',
      'animation': 'assets/lottie/global_trade.json',
    },
    {
      'title': 'Explorez un Catalogue Diversifié',
      'description': 'Trouvez des produits variés, des biscuits aux meubles, tout en un seul endroit.',
      'animation': 'assets/lottie/products.json',
    },
    {
      'title': 'Transactions Sécurisées',
      'description': 'Effectuez des paiements en toute sécurité avec notre système de confiance.',
      'animation': 'assets/lottie/secure.json',
    },
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..forward();

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index, _) {
    setState(() {
      _currentIndex = index;
      _fadeController.forward(from: 0);
    });
  }

  void _navigateToAuth() {
    Modular.to.navigate('/auth');
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Stack(
          children: [
            // Main Content
            Column(
              children: [
                const SizedBox(height: 40),
                // Skip Button
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: TextButton(
                      onPressed: _navigateToAuth,
                      child: Text(
                        'Passer',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: const Color(0xFF6B7280),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: screenHeight * 0.7), // Limit carousel height to 70% of screen
                      child: CarouselSlider.builder(
                        carouselController: _carouselController,
                        itemCount: _onboardingPages.length,
                        itemBuilder: (context, index, realIndex) {
                          return _buildOnboardingPage(
                            title: _onboardingPages[index]['title']!,
                            description: _onboardingPages[index]['description']!,
                            animation: _onboardingPages[index]['animation']!,
                            isDesktop: isDesktop,
                          );
                        },
                        options: CarouselOptions(
                          height: double.infinity,
                          viewportFraction: 1.0,
                          enableInfiniteScroll: false,
                          onPageChanged: _onPageChanged,
                        ),
                      ),
                    ),
                  ),
                ),
                // Dots Indicator
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _onboardingPages.length,
                      (index) => _buildDot(index),
                    ),
                  ),
                ),
                // Next/Get Started Button
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0, left: 24.0, right: 24.0),
                  child: _currentIndex == _onboardingPages.length - 1
                      ? _buildGradientButton(
                          text: 'Commencer',
                          onPressed: _navigateToAuth,
                          isDesktop: isDesktop,
                        )
                      : _buildGradientButton(
                          text: 'Suivant',
                          onPressed: () => _carouselController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                          isDesktop: isDesktop,
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage({
    required String title,
    required String description,
    required String animation,
    required bool isDesktop,
  }) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: double.infinity),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animation with dynamic height
            SizedBox(
              height: isDesktop ? 300 : 200,
              child: Lottie.asset(
                animation,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 40),
            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF00FFFF)],
                ).createShader(bounds),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: isDesktop ? 36 : 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: isDesktop ? 18 : 16,
                  color: const Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 10,
      width: _currentIndex == index ? 30 : 10,
      decoration: BoxDecoration(
        color: _currentIndex == index ? const Color(0xFF6C63FF) : const Color(0xFF6B7280).withOpacity(0.3),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Widget _buildGradientButton({
    required String text,
    required VoidCallback onPressed,
    required bool isDesktop,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFF6C63FF), Color(0xFF00FFFF)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C63FF).withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 40 : 30,
            vertical: isDesktop ? 20 : 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.montserrat(
            fontSize: isDesktop ? 18 : 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}