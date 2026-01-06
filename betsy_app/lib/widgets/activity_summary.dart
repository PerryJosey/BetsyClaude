import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../core/constants/activity_types.dart';

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

  @override
  Widget build(BuildContext context) {
    final activeDays = weekData.where((active) => active).length;
    
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'This Week',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppTheme.spacingM),
          
          // Week visualization
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              final isActive = weekData[index];
              final isToday = index == DateTime.now().weekday - 1;
              
              return _DayIndicator(
                day: ['M', 'T', 'W', 'T', 'F', 'S', 'S'][index],
                isActive: isActive,
                isToday: isToday,
              );
            }),
          ),
          
          const SizedBox(height: AppTheme.spacingL),
          
          // Stats
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.calendar_today_rounded,
                  value: '$activeDays',
                  label: 'Active days',
                  color: AppTheme.successGreen,
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: _StatCard(
                  icon: Icons.fitness_center_rounded,
                  value: '$totalActivities',
                  label: 'Activities',
                  color: AppTheme.primaryBlue,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppTheme.spacingM),
          
          // Favorite activity
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            decoration: BoxDecoration(
              color: favoriteActivity.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Text(
                  favoriteActivity.emoji,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: AppTheme.spacingS),
                Text(
                  'Most active: ${favoriteActivity.name}',
                  style: TextStyle(
                    fontSize: 16,
                    color: favoriteActivity.color,
                    fontWeight: FontWeight.w600,
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

class _DayIndicator extends StatelessWidget {
  final String day;
  final bool isActive;
  final bool isToday;

  const _DayIndicator({
    required this.day,
    required this.isActive,
    required this.isToday,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          day,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
            color: isToday ? AppTheme.primaryBlue : AppTheme.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive
                ? AppTheme.successGreen
                : Colors.grey.shade200,
            border: isToday
                ? Border.all(
                    color: AppTheme.primaryBlue,
                    width: 2,
                  )
                : null,
          ),
          child: isActive
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 20,
                )
              : null,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: AppTheme.spacingS),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: color.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
