import 'package:flutter/material.dart';
import 'package:rental_car/core/widgets/widgets.dart';

/// Top App Bar thống nhất cho trang Profile (Logo NextUnity AI, Streak và Thông báo)
class ProfileTopBar extends StatelessWidget {
  const ProfileTopBar({super.key, this.streak});

  final int? streak;

  @override
  Widget build(BuildContext context) {
    return MainTabHeader(subtitle: 'Hồ sơ cá nhân', streak: streak);
  }
}
