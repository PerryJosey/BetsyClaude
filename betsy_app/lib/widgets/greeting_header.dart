import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

/// Greeting header with Betsy as a confident companion.
/// 
/// "Steady Stride" aesthetic: bold, direct, confident.
class GreetingHeader extends StatefulWidget {
  final String userName;
  final int level;

  const GreetingHeader({
    super.key,
    required this.userName,
    required this.level,
  });

  @override
  State<GreetingHeader> createState() => _GreetingHeaderState();
}

class _GreetingHeaderState extends State<GreetingHeader> 
    with SingleTickerProviderStateMixin {
  late AnimationController _breathingController;
  late Animation<double> _breathingAnimation;

  @override
  void initState() {
    super.initState();
    // Gentle breathing animation for Betsy - she's alive, not static
    _breathingController = AnimationController(
      duration: AppTheme.animationBreathing,
      vsync: this,
    )..repeat(reverse: true);
    
    _breathingAnimation = Tween<double>(
      begin: 1.0,
      end: 1.03,
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

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  // Direct, confident messages
  String _getBoldMessage() {
    final messages = [
      'Let\'s get moving.',
      'Ready to go?',
      'Make it count.',
      'You\'ve got this.',
      'Time to move.',
    ];
    return messages[DateTime.now().day % messages.length];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppTheme.spacingL,
        AppTheme.spacingXL,
        AppTheme.spacingL,
        AppTheme.spacingM,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Betsy avatar - breathing, alive
          AnimatedBuilder(
            animation: _breathingAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _breathingAnimation.value,
                child: child,
              );
            },
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.parchment,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.walnut.withValues(alpha: 0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/BetsyWalks480.gif',
                  width: 72,
                  height: 72,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          
          const SizedBox(width: AppTheme.spacingM),
          
          // Greeting text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppTheme.spacingXS),
                Text(
                  '${_getGreeting()},',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  widget.userName,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXS),
                Text(
                  _getBoldMessage(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          
          // Level indicator - subtle, not shouty
          _LevelIndicator(level: widget.level),
        ],
      ),
    );
  }
}

/// Bold level indicator
class _LevelIndicator extends StatelessWidget {
  final int level;

  const _LevelIndicator({required this.level});

  String _getLevelName() {
    switch (level) {
      case 1: return 'Starter';
      case 2: return 'Mover';
      case 3: return 'Steady';
      case 4: return 'Strong';
      case 5: return 'Elite';
      default: return 'Legend';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingM,
        vertical: AppTheme.spacingS,
      ),
      decoration: BoxDecoration(
        color: AppTheme.amber,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppTheme.amber.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.bolt_rounded,
            color: Colors.white,
            size: 18,
          ),
          const SizedBox(width: 4),
          Text(
            _getLevelName(),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
