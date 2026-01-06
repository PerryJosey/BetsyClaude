import 'package:flutter/material.dart';

class ActivityType {
  final String id;
  final String name;
  final String emoji;
  final Color color;
  final String description;

  const ActivityType({
    required this.id,
    required this.name,
    required this.emoji,
    required this.color,
    required this.description,
  });
}

class ActivityTypes {
  static const List<ActivityType> defaultActivities = [
    ActivityType(
      id: 'walk',
      name: 'Walk',
      emoji: '🚶',
      color: Color(0xFF4A90E2),
      description: 'A stroll around the neighborhood or park',
    ),
    ActivityType(
      id: 'water_aerobics',
      name: 'Water Aerobics',
      emoji: '🏊',
      color: Color(0xFF00BCD4),
      description: 'Gentle exercises in the pool',
    ),
    ActivityType(
      id: 'gardening',
      name: 'Gardening',
      emoji: '🌱',
      color: Color(0xFF7ED321),
      description: 'Tending to plants and flowers',
    ),
    ActivityType(
      id: 'tai_chi',
      name: 'Tai Chi',
      emoji: '🧘',
      color: Color(0xFF9C27B0),
      description: 'Gentle flowing movements',
    ),
    ActivityType(
      id: 'dancing',
      name: 'Dancing',
      emoji: '💃',
      color: Color(0xFFFF6B6B),
      description: 'Moving to your favorite music',
    ),
    ActivityType(
      id: 'stretching',
      name: 'Stretching',
      emoji: '🤸',
      color: Color(0xFFFF9F40),
      description: 'Gentle stretches and flexibility',
    ),
    ActivityType(
      id: 'social',
      name: 'Social Activity',
      emoji: '👥',
      color: Color(0xFFE91E63),
      description: 'Time with friends and family',
    ),
    ActivityType(
      id: 'errands',
      name: 'Out & About',
      emoji: '🛒',
      color: Color(0xFF795548),
      description: 'Shopping, errands, appointments',
    ),
    ActivityType(
      id: 'hobby',
      name: 'Hobby Time',
      emoji: '🎨',
      color: Color(0xFFFF5722),
      description: 'Crafts, reading, or other hobbies',
    ),
    ActivityType(
      id: 'pet_care',
      name: 'Pet Care',
      emoji: '🐕',
      color: Color(0xFF607D8B),
      description: 'Walking or playing with pets',
    ),
  ];
}
