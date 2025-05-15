import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';

class AuthSelectionView extends StatefulWidget {
  const AuthSelectionView({super.key});

  @override
  State<AuthSelectionView> createState() => _AuthSelectionViewState();
}

class _AuthSelectionViewState extends State<AuthSelectionView> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..forward();

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _navigateToRegister() {
    Modular.to.navigate('/auth/register');
  }

  void _navigateToLogin() {
    Modular.to.navigate('/auth/login');
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFF5F7FA),
              const Color(0xFFEDEFF5).withOpacity(0.8),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: isDesktop ? 500 : double.infinity),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: Image.asset(
                            'assets/images/gthint.png',
                            height: isDesktop ? 150 : 120,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [Color(0xFF6C63FF), Color(0xFF00FFFF)],
                            ).createShader(bounds),
                            child: Text(
                              'Bienvenue sur GlobalTrade Hub',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                fontSize: isDesktop ? 40 : 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Text(
                          'Rejoignez le commerce mondial ou connectez-vous pour commencer',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontSize: isDesktop ? 18 : 16,
                            color: const Color(0xFF6B7280),
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: _buildGradientButton(
                            text: 'S\'inscrire',
                            onPressed: _navigateToRegister,
                            isDesktop: isDesktop,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: _buildOutlineButton(
                            text: 'Se connecter',
                            onPressed: _navigateToLogin,
                            isDesktop: isDesktop,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGradientButton({
    required String text,
    required VoidCallback onPressed,
    required bool isDesktop,
  }) {
    return Container(
      width: isDesktop ? 350 : double.infinity,
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
            vertical: isDesktop ? 18 : 16,
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

  Widget _buildOutlineButton({
    required String text,
    required VoidCallback onPressed,
    required bool isDesktop,
  }) {
    return Container(
      width: isDesktop ? 350 : double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF6C63FF), width: 2),
          padding: EdgeInsets.symmetric(
            vertical: isDesktop ? 16 : 14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          foregroundColor: const Color(0xFF6C63FF),
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