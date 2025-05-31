import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Animation utility class to provide consistent animations across the app
class AppAnimations {
  // Private constructor to prevent instantiation
  AppAnimations._();

  // Animation durations
  static const Duration veryFast = Duration(milliseconds: 200);
  static const Duration fast = Duration(milliseconds: 400);
  static const Duration medium = Duration(milliseconds: 600);
  static const Duration slow = Duration(milliseconds: 800);
  static const Duration verySlow = Duration(milliseconds: 1200);

  // Button press animation
  static List<Effect> buttonPressEffects() => [
    ScaleEffect(
      begin: const Offset(1.0, 1.0),
      end: const Offset(0.95, 0.95),
      duration: veryFast,
    ),
    ScaleEffect(
      begin: const Offset(0.95, 0.95),
      end: const Offset(1.0, 1.0),
      duration: veryFast,
    ),
  ];

  // Fade in animation
  static List<Effect> fadeInEffect({Duration? duration}) => [
    FadeEffect(
      begin: 0.0,
      end: 1.0,
      duration: duration ?? medium,
      curve: Curves.easeInOut,
    ),
  ];

  // Slide in animation from bottom
  static List<Effect> slideInFromBottomEffect({Duration? duration}) => [
    SlideEffect(
      begin: const Offset(0.0, 0.2),
      end: Offset.zero,
      duration: duration ?? medium,
      curve: Curves.easeOutCubic,
    ),
    FadeEffect(
      begin: 0.0,
      end: 1.0,
      duration: duration ?? medium,
      curve: Curves.easeInOut,
    ),
  ];

  // Slide in animation from left
  static List<Effect> slideInFromLeftEffect({Duration? duration}) => [
    SlideEffect(
      begin: const Offset(-0.2, 0.0),
      end: Offset.zero,
      duration: duration ?? medium,
      curve: Curves.easeOutCubic,
    ),
    FadeEffect(
      begin: 0.0,
      end: 1.0,
      duration: duration ?? medium,
      curve: Curves.easeInOut,
    ),
  ];

  // Slide in animation from right
  static List<Effect> slideInFromRightEffect({Duration? duration}) => [
    SlideEffect(
      begin: const Offset(0.2, 0.0),
      end: Offset.zero,
      duration: duration ?? medium,
      curve: Curves.easeOutCubic,
    ),
    FadeEffect(
      begin: 0.0,
      end: 1.0,
      duration: duration ?? medium,
      curve: Curves.easeInOut,
    ),
  ];

  // Bounce animation
  static List<Effect> bounceEffect({Duration? duration}) => [
    ScaleEffect(
      begin: const Offset(0.8, 0.8),
      end: const Offset(1.05, 1.05),
      duration: (duration ?? medium) ~/ 2,
      curve: Curves.easeOutCubic,
    ),
    ScaleEffect(
      begin: const Offset(1.05, 1.05),
      end: const Offset(1.0, 1.0),
      duration: (duration ?? medium) ~/ 2,
      curve: Curves.easeInOutCubic,
    ),
  ];

  // Pulse animation (for attention)
  static List<Effect> pulseEffect({Duration? duration}) => [
    ScaleEffect(
      begin: const Offset(1.0, 1.0),
      end: const Offset(1.05, 1.05),
      duration: (duration ?? medium) ~/ 2,
      curve: Curves.easeInOut,
    ),
    ScaleEffect(
      begin: const Offset(1.05, 1.05),
      end: const Offset(1.0, 1.0),
      duration: (duration ?? medium) ~/ 2,
      curve: Curves.easeInOut,
    ),
  ];

  // Staggered list item animation
  static List<Effect> listItemEffect(int index, {Duration? delay}) => [
    FadeEffect(
      begin: 0.0,
      end: 1.0,
      delay: delay ?? Duration(milliseconds: 50 * index),
      duration: medium,
      curve: Curves.easeInOut,
    ),
    SlideEffect(
      begin: const Offset(0.0, 0.1),
      end: Offset.zero,
      delay: delay ?? Duration(milliseconds: 50 * index),
      duration: medium,
      curve: Curves.easeOutCubic,
    ),
  ];
}
