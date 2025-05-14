import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math.dart' as vector;

class HomeStats extends StatefulWidget {
  const HomeStats({super.key});

  @override
  State<HomeStats> createState() => _HomeStatsState();
}

class _HomeStatsState extends State<HomeStats> with TickerProviderStateMixin {
  late final AnimationController _rotationController;
  late final AnimationController _pulseController;
  late final AnimationController _counterController;
  final List<double> _currentValues = [0, 0, 0, 0];
  final List<double> _targetValues = [10.5, 25, 98.7, 150];

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _counterController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _counterController.addListener(() {
      setState(() {
        for (int i = 0; i < _currentValues.length; i++) {
          _currentValues[i] = _targetValues[i] * _counterController.value;
        }
      });
    });

    _counterController.forward();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    _counterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0F1E),
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
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF6C63FF), Color(0xFF00FFFF)],
            ).createShader(bounds),
            child: Text(
              'Impact Global',
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
              _buildFuturisticStatCard(
                _currentValues[0].toStringAsFixed(1) + 'M',
                'Produits Disponibles',
                'inventory_2',
                0,
              ),
              _buildFuturisticStatCard(
                _currentValues[1].toStringAsFixed(0) + 'k',
                'Fournisseurs Vérifiés',
                'verified',
                1,
              ),
              _buildFuturisticStatCard(
                _currentValues[2].toStringAsFixed(1) + '%',
                'Satisfaction Client',
                'workspace_premium',
                2,
              ),
              _buildFuturisticStatCard(
                _currentValues[3].toStringAsFixed(0) + 'k',
                'Commandes Livrées',
                'rocket_launch',
                3,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFuturisticStatCard(
      String value, String label, String icon, int index) {
    return AnimatedBuilder(
      animation: Listenable.merge([_rotationController, _pulseController]),
      builder: (context, child) {
        return Container(
          width: 280,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1F2E),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF6C63FF).withOpacity(0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6C63FF)
                    .withOpacity(0.2 * _pulseController.value),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: HexagonPainter(
                    rotation: _rotationController.value * 2 * math.pi,
                    color: const Color(0xFF6C63FF).withOpacity(0.1),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C63FF).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      IconData(int.parse('e${index + 1}1c', radix: 16),
                          fontFamily: 'MaterialIcons'),
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
                        const Color(0xFF6C63FF),
                      ],
                      stops: const [0.0, 0.5, 1.0],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Text(
                      value,
                      style: GoogleFonts.orbitron(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    label,
                    style: GoogleFonts.spaceMono(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
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

class HexagonPainter extends CustomPainter {
  final double rotation;
  final Color color;

  HexagonPainter({required this.rotation, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) * 0.4;

    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = vector.radians(60.0 * i.toDouble() + rotation);
      final point = center +
          Offset(
            radius * math.cos(angle),
            radius * math.sin(angle),
          );
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(HexagonPainter oldDelegate) =>
      rotation != oldDelegate.rotation || color != oldDelegate.color;
}