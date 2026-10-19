import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

class CourseDetailBottomBar extends StatelessWidget {
  const CourseDetailBottomBar({
    super.key,
    required this.isEnrolled,
    required this.isEnrolling,
    required this.onTapPrimary,
    this.isCompleted = false,
    this.isPremium = false,
    this.isUserPlus = false,
    this.lessonLabel = 'Bài 1.1 • 15 phút học',
  });

  final bool isEnrolled;
  final bool isEnrolling;
  final bool isCompleted;
  final bool isPremium;
  final bool isUserPlus;
  final VoidCallback onTapPrimary;
  final String lessonLabel;

  @override
  Widget build(BuildContext context) {
    final String topLabel;
    final String subLabel;
    final String buttonLabel;

    if (isCompleted) {
      topLabel = 'ĐÃ HOÀN THÀNH';
      subLabel = 'Bạn đã hoàn thành tất cả bài học';
      buttonLabel = 'Ôn tập lại';
    } else if (isEnrolled) {
      topLabel = 'ĐÃ KÍCH HOẠT';
      subLabel = lessonLabel;
      buttonLabel = 'Vào học ngay';
    } else if (isPremium) {
      topLabel = 'NEXTUNITY PLUS';
      subLabel = isUserPlus
          ? 'Quyền lợi Plus khả dụng'
          : 'Yêu cầu tài khoản Plus';
      buttonLabel = isUserPlus ? 'Đăng ký ngay' : 'Nâng cấp Plus';
    } else {
      topLabel = 'CHƯƠNG TRÌNH FPT';
      subLabel = 'Miễn phí cho sinh viên';
      buttonLabel = 'Đăng ký học ngay';
    }

    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.94),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0F172A).withValues(alpha: 0.12),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isEnrolled
                              ? const Color(0xFF10B981)
                              : (isPremium
                                    ? const Color(0xFFF59E0B)
                                    : AppColors.primary),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        topLabel,
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w900,
                          color: isEnrolled
                              ? const Color(0xFF059669)
                              : (isPremium
                                    ? const Color(0xFFD97706)
                                    : AppColors.primary),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subLabel,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            InkWell(
              onTap: isEnrolling ? null : onTapPrimary,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: 42,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3D5AFE), Color(0xFF2563EB)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3D5AFE).withValues(alpha: 0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: isEnrolling
                    ? const Center(
                        child: SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            buttonLabel,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 15,
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
