import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';

/// Widget hiển thị thông tin tác giả và lựa chọn quyền riêng tư khi đăng bài
class CreatePostHeaderInfo extends StatelessWidget {
  const CreatePostHeaderInfo({
    super.key,
    required this.userName,
    this.avatarUrl,
    required this.privacy,
    required this.onPickPrivacy,
  });

  final String userName;
  final String? avatarUrl;
  final String privacy;
  final VoidCallback onPickPrivacy;

  @override
  Widget build(BuildContext context) {
    final initial = userName.trim().isNotEmpty ? userName.trim()[0] : 'U';

    return Row(
      children: [
        _buildAvatar(avatarUrl, initial),
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
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: [
                  // Chọn Quyền riêng tư / Phạm vi
                  InkWell(
                    onTap: onPickPrivacy,
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3.5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.public_rounded,
                            size: 13,
                            color: Color(0xFF10B981),
                          ),
                          const Gap.h(4),
                          Text(
                            privacy,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF334155),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_drop_down_rounded,
                            size: 16,
                            color: Color(0xFF64748B),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Huy hiệu Trường học
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3.5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF2FF),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFE0E7FF)),
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
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar(String? avatarUrl, String initial) {
    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      return CircleAvatar(
        radius: 20,
        backgroundColor: const Color(0xFF3D5AFE),
        backgroundImage: NetworkImage(avatarUrl),
        onBackgroundImageError: (_, _) {},
        child: Text(
          initial.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }

    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xFF3D5AFE), Color(0xFF60A5FA)],
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        initial.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
