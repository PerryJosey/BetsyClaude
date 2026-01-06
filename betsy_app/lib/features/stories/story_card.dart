import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// Story card with "Steady Stride" aesthetic.
/// 
/// Clean, bold, direct. No frills.
/// Strong typography, clear hierarchy.
class StoryCard extends StatelessWidget {
  final String title;
  final String preview;
  final String authorName;
  final int authorAge;
  final int readTime;

  const StoryCard({
    super.key,
    required this.title,
    required this.preview,
    required this.authorName,
    required this.authorAge,
    required this.readTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // Paper-like background
        color: AppTheme.cardBackgroundWarm,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.parchment,
          width: 1,
        ),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Betsy and metadata
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Betsy avatar with warm border
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.electricCyan,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.walnut.withValues(alpha: 0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                          BoxShadow(
                            color: AppTheme.electricCyan.withValues(alpha: 0.18),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/BetsyWalks480.gif',
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacingM),
                    
                    // Title and author
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textPrimary,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'From $authorName, age $authorAge',
                            style: TextStyle(
                              fontSize: 15,
                              color: AppTheme.textMuted,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: AppTheme.spacingM),
                
                // Clean divider
                Container(
                  height: 2,
                  color: AppTheme.gray200,
                ),
                
                const SizedBox(height: AppTheme.spacingM),
                
                // Quote preview - bold styling
                Text(
                  '"$preview"',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimary,
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: AppTheme.spacingL),
                
                // Footer with read time and action
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Read time
                    Row(
                      children: [
                        Icon(
                          Icons.schedule_rounded,
                          size: 18,
                          color: AppTheme.textMuted,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '$readTime min read',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.textMuted,
                          ),
                        ),
                      ],
                    ),
                    
                    // Read action
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingM,
                        vertical: AppTheme.spacingS,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.electricCyan,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Continue reading',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 18,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
