import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// Streak card with "Steady Stride" aesthetic.
/// 
/// Bold, confident, direct. Strong visual impact.
/// Deep slate with bold amber accent.
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

class _StreakCardState extends State<StreakCard> 
    with SingleTickerProviderStateMixin {
  late AnimationController _breathingController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    // Gentle breathing glow - subtle, not distracting
    _breathingController = AnimationController(
      duration: AppTheme.animationBreathing,
      vsync: this,
    )..repeat(reverse: true);
    
    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _breathingController,
      curve: AppTheme.curveBreathing,
    ));
  }

  @override
  void dispose() {
    _breathingController.dispose();
    super.dispose();
  }

  // Direct, confident messages
  String _getBoldMessage() {
    if (widget.currentStreak == 0) return 'Start strong today.';
    if (widget.currentStreak == 1) return 'Day one. Let\'s go.';
    if (widget.currentStreak < 7) return 'Building momentum.';
    if (widget.currentStreak < 14) return 'Solid week. Keep pushing.';
    if (widget.currentStreak < 30) return 'You\'re on a roll.';
    return 'Unstoppable.';
  }

  // Bold, strong icons
  String _getStreakIcon() {
    if (widget.currentStreak < 7) return '💪';
    if (widget.currentStreak < 14) return '🔥';
    if (widget.currentStreak < 30) return '⚡';
    if (widget.currentStreak < 60) return '🏆';
    return '👑';
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.slate,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppTheme.electricCyan.withValues(alpha: 0.4),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.slate.withValues(alpha: 0.3),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(24),
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main streak display
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Organic icon
                        Text(
                          _getStreakIcon(),
                          style: const TextStyle(fontSize: 44),
                        ),
                        const SizedBox(width: AppTheme.spacingM),
                        
                        // Streak number
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  widget.currentStreak.toString(),
                                  style: TextStyle(
                                    fontSize: 52,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                    height: 1.0,
                                    letterSpacing: -2,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  widget.currentStreak == 1 ? 'day' : 'days',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white.withValues(alpha: 0.9),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'of gentle movement',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white.withValues(alpha: 0.8),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        
                        const Spacer(),
                        
                        // Rest days (not "freeze" - warmer language)
                        if (widget.hasFreezeDays)
                          _RestDaysIndicator(
                            daysRemaining: widget.freezeDaysRemaining,
                          ),
                      ],
                    ),
                    
                    const SizedBox(height: AppTheme.spacingL),
                    
                    // Warm message
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingM,
                        vertical: AppTheme.spacingS + 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.format_quote_rounded,
                            color: Colors.white.withValues(alpha: 0.6),
                            size: 20,
                          ),
                          const SizedBox(width: AppTheme.spacingS),
                          Expanded(
                            child: Text(
                              _getBoldMessage(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Rest days indicator - gentler language than "freeze"
class _RestDaysIndicator extends StatelessWidget {
  final int daysRemaining;

  const _RestDaysIndicator({required this.daysRemaining});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingM,
        vertical: AppTheme.spacingS,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '☕',
            style: const TextStyle(fontSize: 22),
          ),
          const SizedBox(height: 2),
          Text(
            '$daysRemaining',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          Text(
            'rest days',
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
        ],
      ),
    );
  }
}
