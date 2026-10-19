import 'package:flutter/material.dart';
import 'package:rental_car/core/utils/string_utils.dart';

/// A circular avatar that shows an image when available and falls back to the
/// user's initials otherwise.
class AppAvatar extends StatelessWidget {
  const AppAvatar({
    required this.name,
    this.imageUrl,
    this.radius = 20,
    super.key,
  });

  final String name;
  final String? imageUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasImage = imageUrl != null && imageUrl!.isNotEmpty;

    return CircleAvatar(
      radius: radius,
      backgroundColor: theme.colorScheme.primaryContainer,
      foregroundImage: hasImage ? NetworkImage(imageUrl!) : null,
      onForegroundImageError: hasImage ? (_, _) {} : null,
      child: Text(
        StringUtils.getInitials(name, fallback: '?'),
        style: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
