import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';

/// Widget hiển thị thông tin tác giả khi đăng bài
class CreatePostHeaderInfo extends StatelessWidget {
  const CreatePostHeaderInfo({
    super.key,
    required this.userName,
    this.avatarUrl,
    this.isPlus = false,
  });

  final String userName;
  final String? avatarUrl;
  final bool isPlus;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppAvatar(name: userName, imageUrl: avatarUrl, isPlus: isPlus),
        const Gap.h(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
              const Gap(3),
              // Huy hiệu Trường học
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3.5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.primaryBorder),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.school_rounded,
                      size: 13,
                      color: AppColors.primary,
                    ),
                    Gap.h(4),
                    Text(
                      'FPT University',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
