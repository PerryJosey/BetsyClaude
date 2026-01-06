import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../core/constants/activity_types.dart';

/// Weekly activity summary with "Steady Stride" aesthetic.
/// 
/// Bold, clean visualization. Checkmarks for completed days.
/// Direct and confident.
class ActivitySummary extends StatelessWidget {
  final List<bool> weekData;
  final int totalActivities;
  final ActivityType favoriteActivity;

  const ActivitySummary({
    super.key,
    required this.weekData,
    required this.totalActivities,
    required this.favoriteActivity,
  });

  String _getBoldMessage(int activeDays) {
    if (activeDays == 0) return 'New week. Fresh start.';
    if (activeDays == 1) return 'One down. Keep going.';
    if (activeDays < 4) return 'Gaining ground.';
    if (activeDays < 6) return 'Strong week.';
    return 'Crushed it.';
  }

  @override
  Widget build(BuildContext context) {
    final activeDays = weekData.where((active) => active).length;
    
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: AppTheme.paperDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Week',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getBoldMessage(activeDays),
                    style: TextStyle(
                      fontSize: 15,
                      color: AppTheme.textMuted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              // Mini summary
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingM,
                  vertical: AppTheme.spacingS,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.slate,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Text(
                      '$activeDays',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '/7',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppTheme.spacingXL),
          
          // Week visualization - garden row
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingS,
              vertical: AppTheme.spacingM,
            ),
            decoration: BoxDecoration(
              color: AppTheme.linen,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.parchment),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(7, (index) {
                final isActive = weekData[index];
                final isToday = index == DateTime.now().weekday - 1;
                
                return _GardenDay(
                  dayName: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index],
                  isActive: isActive,
                  isToday: isToday,
                );
              }),
            ),
          ),
          
          const SizedBox(height: AppTheme.spacingL),
          
          // Favorite activity highlight
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            decoration: BoxDecoration(
              color: AppTheme.gray100,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppTheme.gray200,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppTheme.cardBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      favoriteActivity.emoji,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(width: AppTheme.spacingM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your favorite this week',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.textMuted,
                        ),
                      ),
                      Text(
                        favoriteActivity.name,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '$totalActivities times',
                  style: TextStyle(
                    fontSize: 15,
                    color: AppTheme.terracotta,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Single day indicator - bold checkmark style
class _GardenDay extends StatelessWidget {
  final String dayName;
  final bool isActive;
  final bool isToday;

  const _GardenDay({
    required this.dayName,
    required this.isActive,
    required this.isToday,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Bold checkmark indicator
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isActive 
                ? AppTheme.success
                : AppTheme.gray100,
            shape: BoxShape.circle,
            border: isToday
                ? Border.all(color: AppTheme.electricCyan, width: 3)
                : null,
            boxShadow: isActive ? [
              BoxShadow(
                color: AppTheme.success.withValues(alpha: 0.25),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ] : null,
          ),
          child: Center(
            child: isActive 
                ? Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 22,
                  )
                : null,
          ),
        ),
        const SizedBox(height: 6),
        // Day label
        Text(
          dayName,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isToday ? FontWeight.w700 : FontWeight.w500,
            color: isToday ? AppTheme.electricCyanDark : AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}
