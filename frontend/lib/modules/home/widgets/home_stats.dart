import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class HomeStats extends StatefulWidget {
  const HomeStats({super.key});

  @override
  State<HomeStats> createState() => _HomeStatsState();
}

class _HomeStatsState extends State<HomeStats> with TickerProviderStateMixin {
  late final List<AnimationController> _counterControllers;
  late final AnimationController _rotationController;
  late final AnimationController _slideController;

  final List<StatData> stats = [
    StatData(
      title: 'Produits disponibles',
      value: 15000,
      suffix: '+',
      icon: Icons.inventory_2,
      gradient: const [Color(0xFF6C63FF), Color(0xFF4834DF)],
    ),
    StatData(
      title: 'Fournisseurs vérifiés',
      value: 500,
      suffix: '+',
      icon: Icons.verified_user,
      gradient: const [Color(0xFF00FFFF), Color(0xFF6C63FF)],
    ),
    StatData(
      title: 'Satisfaction client',
      value: 98,
      suffix: '%',
      icon: Icons.thumb_up,
      gradient: const [Color(0xFF4834DF), Color(0xFF00FFFF)],
    ),
    StatData(
      title: 'Commandes livrées',
      value: 25000,
      suffix: '+',
      icon: Icons.local_shipping,
      gradient: const [Color(0xFF6C63FF), Color(0xFF00FFFF)],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _counterControllers = List.generate(
      stats.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 2000),
        vsync: this,
      ),
    );

    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();

    for (var i = 0; i < _counterControllers.length; i++) {
      Future.delayed(Duration(milliseconds: 200 * i), () {
        if (mounted) {
          _counterControllers[i].forward();
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _counterControllers) {
      controller.dispose();
    }
    _rotationController.dispose();
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
          color: const Color(0xFFEDEFF5), // Slightly darker gray for contrast
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
                        'Notre Impact en Chiffres',
                        style: GoogleFonts.montserrat(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF6C63FF),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Des résultats concrets qui témoignent de notre expertise',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: const Color(0xFF6B7280),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 60),
              LayoutBuilder(
                builder: (context, constraints) {
                  return Wrap(
                    spacing: 40,
                    runSpacing: 40,
                    alignment: WrapAlignment.center,
                    children: List.generate(
                      stats.length,
                      (index) => _StatCard(
                        data: stats[index],
                        counterController: _counterControllers[index],
                        rotationController: _rotationController,
                        delay: Duration(milliseconds: 200 * index),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StatCard extends StatefulWidget {
  final StatData data;
  final AnimationController counterController;
  final AnimationController rotationController;
  final Duration delay;

  const _StatCard({
    required this.data,
    required this.counterController,
    required this.rotationController,
    required this.delay,
  });

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> with SingleTickerProviderStateMixin {
  late Animation<double> _counterAnimation;
  late AnimationController _hoverController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _counterAnimation = Tween<double>(
      begin: 0,
      end: widget.data.value.toDouble(),
    ).animate(CurvedAnimation(
      parent: widget.counterController,
      curve: Curves.easeOut,
    ));

    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _hoverController.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _hoverController.reverse();
      },
      child: AnimatedBuilder(
        animation: Listenable.merge([
          widget.rotationController,
          _hoverController,
          widget.counterController,
        ]),
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 + (0.05 * _hoverController.value),
            child: Container(
              width: 280,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6C63FF).withOpacity(0.2 + (0.3 * _hoverController.value)),
                    blurRadius: 15 + (15 * _hoverController.value),
                    spreadRadius: 2 + (2 * _hoverController.value),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: HexagonPainter(
                        rotation: widget.rotationController.value * 2 * math.pi,
                        color: const Color(0xFF6C63FF).withOpacity(0.1),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        widget.data.icon,
                        color: const Color(0xFF6C63FF),
                        size: 48,
                      ),
                      const SizedBox(height: 24),
                      AnimatedBuilder(
                        animation: _counterAnimation,
                        builder: (context, child) {
                          return Text(
                            '${_counterAnimation.value.round()}${widget.data.suffix}',
                            style: GoogleFonts.montserrat(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF2D3748),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.data.title,
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: const Color(0xFF6B7280),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
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
    final radius = math.min(size.width, size.height) / 2;

    final path = Path();
    for (var i = 0; i < 6; i++) {
      final angle = rotation + (i * math.pi / 3);
      final point = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
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

class StatData {
  final String title;
  final int value;
  final String suffix;
  final IconData icon;
  final List<Color> gradient;

  StatData({
    required this.title,
    required this.value,
    required this.suffix,
    required this.icon,
    required this.gradient,
  });
}