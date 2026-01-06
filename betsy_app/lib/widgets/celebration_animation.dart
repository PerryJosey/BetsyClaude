import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/theme/app_theme.dart';

class CelebrationAnimation extends StatefulWidget {
  const CelebrationAnimation({super.key});

  @override
  State<CelebrationAnimation> createState() => _CelebrationAnimationState();
}

class _CelebrationAnimationState extends State<CelebrationAnimation>
    with TickerProviderStateMixin {
  late AnimationController _starController;
  late AnimationController _confettiController;
  late Animation<double> _starScale;
  late Animation<double> _starRotation;
  final List<ConfettiParticle> _particles = [];

  @override
  void initState() {
    super.initState();
    
    // Star animation
    _starController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _starScale = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _starController,
      curve: Curves.elasticOut,
    ));
    
    _starRotation = Tween<double>(
      begin: 0.0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: _starController,
      curve: Curves.easeInOut,
    ));
    
    // Confetti animation
    _confettiController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    
    // Generate confetti particles
    for (int i = 0; i < 50; i++) {
      _particles.add(ConfettiParticle());
    }
    
    _starController.forward();
    _confettiController.forward();
    
    // Auto dismiss after animation
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _starController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Confetti
          AnimatedBuilder(
            animation: _confettiController,
            builder: (context, child) {
              return CustomPaint(
                painter: ConfettiPainter(
                  particles: _particles,
                  progress: _confettiController.value,
                ),
                size: MediaQuery.of(context).size,
              );
            },
          ),
          
          // Star animation
          Center(
            child: AnimatedBuilder(
              animation: _starController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _starScale.value,
                  child: Transform.rotate(
                    angle: _starRotation.value,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppTheme.sunsetOrange.withOpacity(0.8),
                            AppTheme.sunsetOrange.withOpacity(0.0),
                          ],
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '⭐',
                          style: TextStyle(fontSize: 100),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Success message
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _starController,
              builder: (context, child) {
                return Opacity(
                  opacity: _starController.value,
                  child: Column(
                    children: [
                      Text(
                        'Great job!',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Activity logged successfully',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ConfettiParticle {
  final double x = math.Random().nextDouble();
  final double speed = 0.5 + math.Random().nextDouble() * 0.5;
  final double size = 8 + math.Random().nextDouble() * 8;
  final Color color = [
    AppTheme.primaryBlue,
    AppTheme.warmCoral,
    AppTheme.successGreen,
    AppTheme.sunsetOrange,
    AppTheme.lavenderMist,
  ][math.Random().nextInt(5)];
  final double rotation = math.Random().nextDouble() * 2 * math.pi;
}

class ConfettiPainter extends CustomPainter {
  final List<ConfettiParticle> particles;
  final double progress;

  ConfettiPainter({
    required this.particles,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    
    for (final particle in particles) {
      final y = -particle.size + (size.height + particle.size * 2) * progress * particle.speed;
      final x = particle.x * size.width + math.sin(progress * 4 + particle.rotation) * 30;
      
      paint.color = particle.color.withOpacity(1.0 - progress * 0.3);
      
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(particle.rotation + progress * 2);
      
      // Draw confetti shape (rectangle)
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset.zero,
          width: particle.size,
          height: particle.size * 0.6,
        ),
        paint,
      );
      
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(ConfettiPainter oldDelegate) => true;
}
