import 'package:flutter/material.dart';

/// Card listing all exclusive benefits and features of NextUnity Plus.
class PlusBenefitsCard extends StatelessWidget {
  const PlusBenefitsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF183A78).withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'ĐẶC QUYỀN HỘI VIÊN PLUS',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF64748B),
                  letterSpacing: 0.5,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2.5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFFDBEAFE),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.auto_awesome_rounded,
                      color: Color(0xFF2563EB),
                      size: 12,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Mở khóa trọn bộ',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2563EB),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 10),

          // Benefit 1: 100% Khóa học & Đề thi PE / FE
          _buildBenefitRow(
            icon: Icons.check_circle_rounded,
            iconColor: const Color(0xFF059669),
            iconBg: const Color(0xFFECFDF5),
            iconBorder: const Color(0xFFA7F3D0),
            title: '100% Khóa học & Đề thi PE / FE',
            subtitle:
                'Truy cập toàn bộ video bài giảng, đề thi mẫu có đáp án chi tiết các môn SE, IA, GD.',
          ),

          const SizedBox(height: 10),

          // Benefit 2: Trợ lý AI giải bài tập
          _buildBenefitRow(
            icon: Icons.psychology_rounded,
            iconColor: const Color(0xFF2563EB),
            iconBg: const Color(0xFFEFF6FF),
            iconBorder: const Color(0xFFDBEAFE),
            title: 'Trợ lý AI giải bài tập không giới hạn',
            badge: 'GPT-4o',
            subtitle:
                'Giải thích thuật toán từng dòng code, debug lỗi Java, C#, Python 24/7 tức thì.',
          ),

          const SizedBox(height: 10),

          // Benefit 3: Tải tài liệu & Slide bài giảng
          _buildBenefitRow(
            icon: Icons.cloud_download_rounded,
            iconColor: const Color(0xFF2563EB),
            iconBg: const Color(0xFFEFF6FF),
            iconBorder: const Color(0xFFDBEAFE),
            title: 'Tải tài liệu & Slide bài giảng tốc độ cao',
            subtitle:
                'Tải trọn bộ SRS, Database Diagram, slide mẫu không giới hạn băng thông.',
          ),

          const SizedBox(height: 10),

          // Benefit 4: Huy hiệu Plus độc quyền
          _buildBenefitRow(
            icon: Icons.military_tech_rounded,
            iconColor: const Color(0xFFD97706),
            iconBg: const Color(0xFFFFFBEB),
            iconBorder: const Color(0xFFFDE68A),
            title: 'Huy hiệu Plus độc quyền trên cộng đồng',
            subtitle:
                'Huy hiệu vàng kim lấp lánh nhận diện thành viên tích cực, bài viết được ưu tiên hiển thị.',
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitRow({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required Color iconBorder,
    required String title,
    String? badge,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: iconBorder),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    if (badge != null) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDBEAFE),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: const Color(0xFFBFDBFE)),
                        ),
                        child: Text(
                          badge,
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1D4ED8),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF64748B),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
