// filepath: d:\Professional\home_tuition\lib\core\animations\loading_animations.dart
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/app_theme.dart';

/// Loading animation utilities for the app
class LoadingAnimations {
  // Private constructor to prevent instantiation
  LoadingAnimations._();

  // Loading animation
  static Widget loadingAnimation({
    double size = 200,
    Color? color,
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: Lottie.asset(
        'assets/animations/loading.json',
        width: size,
        height: size,
        fit: BoxFit.contain,
        // If Lottie fails to load, fallback to CircularProgressIndicator
        errorBuilder: (context, error, stackTrace) => Center(
          child: CircularProgressIndicator(
            color: color ?? AppTheme.primaryColor,
          ),
        ),
      ),
    );
  }

  // Success animation
  static Widget successAnimation({
    double size = 200,
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: Lottie.asset(
        'assets/animations/success.json',
        width: size,
        height: size,
        fit: BoxFit.contain,
        repeat: false,
        // Fallback if Lottie fails
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.check_circle_outline,
          size: size / 2,
          color: AppTheme.secondaryColor,
        ),
      ),
    );
  }

  // Error animation
  static Widget errorAnimation({
    double size = 200,
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: Lottie.asset(
        'assets/animations/error.json',
        width: size,
        height: size,
        fit: BoxFit.contain,
        repeat: false,
        // Fallback if Lottie fails
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.error_outline,
          size: size / 2,
          color: AppTheme.errorColor,
        ),
      ),
    );
  }

  // Empty state animation
  static Widget emptyAnimation({
    double size = 200,
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: Icon(
        Icons.inbox_outlined,
        size: size / 2,
        color: AppTheme.textColor.withOpacity(0.5),
      ),
    );
  }

  // Search animation
  static Widget searchAnimation({
    double size = 200,
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: Icon(
        Icons.search,
        size: size / 2,
        color: AppTheme.primaryColor,
      ),
    );
  }

  // Shimmer loading effect for list items
  static Widget shimmerLoading({
    required Widget child,
    Color? baseColor,
    Color? highlightColor,
  }) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey[300]!,
      highlightColor: highlightColor ?? Colors.grey[100]!,
      child: child,
    );
  }

  // Shimmer loading for text
  static Widget shimmerText({
    double height = 16,
    double width = 200,
    double borderRadius = 4,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }

  // Shimmer loading for card
  static Widget shimmerCard({
    double height = 100,
    double? width,
    double borderRadius = 8,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }

  // Shimmer loading for image
  static Widget shimmerImage({
    double height = 100,
    double width = 100,
    double borderRadius = 8,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }

  // Shimmer loading for avatar
  static Widget shimmerAvatar({
    double size = 48,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: size,
        width: size,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
