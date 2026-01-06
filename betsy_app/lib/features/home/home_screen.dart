import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/activity_types.dart';
import '../activities/quick_log_sheet.dart';
import '../stories/story_card.dart';
import '../gamification/streak_card.dart';
import '../../widgets/greeting_header.dart';
import '../../widgets/activity_summary.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  // Mock data - would come from state management
  final int currentStreak = 7;
  final int currentLevel = 3;
  final String userName = "Margaret";
  final List<ActivityType> quickActivities = [
    ActivityTypes.defaultActivities[0], // Walk
    ActivityTypes.defaultActivities[1], // Water Aerobics
    ActivityTypes.defaultActivities[7], // Out & About
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppTheme.animationNormal,
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showQuickLogSheet(ActivityType activity) {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => QuickLogSheet(activity: activity),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: CustomScrollView(
            slivers: [
              // Custom App Bar with Greeting
              SliverToBoxAdapter(
                child: GreetingHeader(
                  userName: userName,
                  level: currentLevel,
                ),
              ),
              
              // Streak Card with gentle motivation
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
                  child: StreakCard(
                    currentStreak: currentStreak,
                    hasFreezeDays: true,
                    freezeDaysRemaining: 2,
                  ),
                ),
              ),
              
              // Quick Activity Logging Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.spacingM),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'How did you move today?',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacingM),
                      ...quickActivities.map((activity) => Padding(
                        padding: const EdgeInsets.only(bottom: AppTheme.spacingS),
                        child: _QuickActivityButton(
                          activity: activity,
                          onTap: () => _showQuickLogSheet(activity),
                        ),
                      )),
                      const SizedBox(height: AppTheme.spacingS),
                      _MoreActivitiesButton(
                        onTap: () {
                          // Navigate to full activities list
                        },
                      ),
                    ],
                  ),
                ),
              ),
              
              // Daily Story Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
                  child: StoryCard(
                    title: "Betsy's Morning Wisdom",
                    preview: "At 87, I've learned that the best exercise is the one you actually do. This morning, I watered my petunias...",
                    authorName: "Betsy",
                    authorAge: 87,
                    readTime: 3,
                  ),
                ),
              ),
              
              // Weekly Activity Summary
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.spacingM),
                  child: ActivitySummary(
                    weekData: [true, true, false, true, true, true, true],
                    totalActivities: 12,
                    favoriteActivity: ActivityTypes.defaultActivities[0],
                  ),
                ),
              ),
              
              // Bottom padding
              const SliverToBoxAdapter(
                child: SizedBox(height: AppTheme.spacingXL),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActivityButton extends StatelessWidget {
  final ActivityType activity;
  final VoidCallback onTap;

  const _QuickActivityButton({
    required this.activity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.08),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: activity.color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    activity.emoji,
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity.name,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tap to log activity',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.add_circle,
                size: 32,
                color: activity.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MoreActivitiesButton extends StatelessWidget {
  final VoidCallback onTap;

  const _MoreActivitiesButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.lavenderMist.withOpacity(0.3),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.apps_rounded,
                color: AppTheme.primaryBlue,
                size: 24,
              ),
              const SizedBox(width: AppTheme.spacingS),
              Text(
                'More Activities',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.primaryBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
