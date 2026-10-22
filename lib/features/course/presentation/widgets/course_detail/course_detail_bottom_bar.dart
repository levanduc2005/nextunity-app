import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Thanh hành động dính dưới màn hình chuẩn phong cách ApSkil (Dual-Action Bottom Bar)
/// Bao gồm 2 nút bấm song song đặc trưng của ApSkil:
/// - Nút phụ bên trái: "Xem giáo trình" (Lihat materi) kèm icon mắt xem
/// - Nút chính bên phải: "Đăng ký học ngay" (Beli kelas) / "Vào học ngay" (Mulai belajar) màu xanh lá ApSkil
class CourseDetailBottomBar extends StatelessWidget {
  const CourseDetailBottomBar({
    super.key,
    required this.isEnrolled,
    required this.isEnrolling,
    required this.onTapPrimary,
    this.onTapCurriculum,
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
  final VoidCallback? onTapCurriculum;
  final String lessonLabel;

  @override
  Widget build(BuildContext context) {
    final String primaryButtonLabel;
    final IconData primaryIcon;

    if (isCompleted) {
      primaryButtonLabel = 'Ôn tập bài học';
      primaryIcon = Icons.replay_rounded;
    } else if (isEnrolled) {
      primaryButtonLabel = 'Vào học ngay';
      primaryIcon = Icons.arrow_forward_rounded;
    } else if (isPremium) {
      primaryButtonLabel = isUserPlus ? 'Đăng ký ngay' : 'Nâng cấp Plus';
      primaryIcon = isUserPlus ? Icons.check_rounded : Icons.workspace_premium_rounded;
    } else {
      primaryButtonLabel = 'Bắt đầu học';
      primaryIcon = Icons.check_rounded;
    }

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: const Border(
            top: BorderSide(color: Color(0xFFE2E8F0)),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0F172A).withValues(alpha: 0.06),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            // 1. Nút phụ bên trái chuẩn ApSkil: 'Xem giáo trình' (Lihat materi)
            Expanded(
              flex: 4,
              child: SizedBox(
                height: 48,
                child: OutlinedButton(
                  onPressed: onTapCurriculum,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF0F172A),
                    side: const BorderSide(color: Color(0xFFCBD5E1)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.visibility_outlined,
                        size: 16,
                        color: Color(0xFF0F172A),
                      ),
                      SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          'Giáo trình',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),

            // 2. Nút chính bên phải chuẩn ApSkil: 'Bắt đầu học' (Beli kelas / Mulai belajar)
            Expanded(
              flex: 6,
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: isEnrolling ? null : onTapPrimary,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                  ),
                  child: isEnrolling
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                primaryButtonLabel,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Icon(
                              primaryIcon,
                              size: 16,
                              color: Colors.white,
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
