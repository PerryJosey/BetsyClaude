import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class StreakCard extends StatefulWidget {
  final int currentStreak;
  final bool hasFreezeDays;
  final int freezeDaysRemaining;

  const StreakCard({
    super.key,
    required this.currentStreak,
    required this.hasFreezeDays,
    required this.freezeDaysRemaining,
  });

  @override
  State<StreakCard> createState() => _StreakCardState();
}

class _StreakCardState extends State<StreakCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _glowAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _pulseAnimation = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _getStreakMessage() {
    if (widget.currentStreak == 0) return 'Start your journey today!';
    if (widget.currentStreak == 1) return 'Great start! Keep it up!';
    if (widget.currentStreak < 7) return 'You\'re building momentum!';
    if (widget.currentStreak < 30) return 'Amazing consistency!';
    return 'You\'re unstoppable!';
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.warmCoral.withOpacity(0.9),
                  AppTheme.sunsetOrange,
                  AppTheme.peachPuff,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0.0, 0.5, 1.0],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.warmCoral.withOpacity(0.3 * _glowAnimation.value),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // Show streak details
                },
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.spacingL),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '🔥',
                                    style: TextStyle(
                                      fontSize: 40,
                                      shadows: [
                                        Shadow(
                                          color: Colors.orange.withOpacity(0.5),
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: AppTheme.spacingS),
                                  Text(
                                    widget.currentStreak.toString(),
                                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 48,
                                    ),
                                  ),
                                  const SizedBox(width: AppTheme.spacingS),
                                  Text(
                                    widget.currentStreak == 1 ? 'day' : 'days',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppTheme.spacingS),
                              Text(
                                _getStreakMessage(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          if (widget.hasFreezeDays)
                            _FreezeIndicator(
                              freezeDaysRemaining: widget.freezeDaysRemaining,
                            ),
                        ],
                      ),
                      if (widget.currentStreak > 0) ...[
                        const SizedBox(height: AppTheme.spacingM),
                        _StreakProgress(currentStreak: widget.currentStreak),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _FreezeIndicator extends StatelessWidget {
  final int freezeDaysRemaining;

  const _FreezeIndicator({required this.freezeDaysRemaining});

  @override
  Widget build(BuildContext context) {
    return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingM,
              vertical: AppTheme.spacingS,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Text(
                  '❄️',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 4),
                Text(
                  '$freezeDaysRemaining',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'freeze days',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
  }
}

class _StreakProgress extends StatelessWidget {
  final int currentStreak;

  const _StreakProgress({required this.currentStreak});

  int _getNextMilestone() {
    if (currentStreak < 7) return 7;
    if (currentStreak < 30) return 30;
    if (currentStreak < 100) return 100;
    return ((currentStreak ~/ 100) + 1) * 100;
  }

  @override
  Widget build(BuildContext context) {
    final nextMilestone = _getNextMilestone();
    final progress = currentStreak / nextMilestone;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Next milestone',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            Text(
              '$nextMilestone days',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacingS),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: Colors.white.withOpacity(0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ],
    );
  }
}
