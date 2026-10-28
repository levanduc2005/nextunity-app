import 'package:flutter/material.dart';
import 'package:rental_car/features/auth/domain/entities/user_entity.dart';
import 'package:rental_car/features/profile/presentation/widgets/decorations/profile_stationery_decorations.dart';
import 'package:rental_car/features/profile/presentation/widgets/edit/edit_profile_action_buttons.dart';
import 'package:rental_car/features/profile/presentation/widgets/edit/edit_profile_avatar_picker.dart';
import 'package:rental_car/features/profile/presentation/widgets/edit/edit_profile_gender_selector.dart';
import 'package:rental_car/features/profile/presentation/widgets/edit/edit_profile_section_title.dart';
import 'package:rental_car/features/profile/presentation/widgets/edit/edit_profile_text_field.dart';

import 'package:rental_car/core/theme/app_colors.dart';
/// Form chỉnh sửa thông tin sinh viên NextUnity bọc trong thẻ phong cách Stationery
class EditProfileForm extends StatelessWidget {
  const EditProfileForm({
    super.key,
    required this.formKey,
    required this.user,
    required this.nameController,
    required this.studentIdController,
    required this.universityController,
    required this.majorController,
    required this.cohortController,
    required this.bioController,
    required this.selectedGender,
    required this.onGenderChanged,
    required this.isUpdating,
    required this.onCancel,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final UserEntity? user;
  final TextEditingController nameController;
  final TextEditingController studentIdController;
  final TextEditingController universityController;
  final TextEditingController majorController;
  final TextEditingController cohortController;
  final TextEditingController bioController;
  final String? selectedGender;
  final ValueChanged<String> onGenderChanged;
  final bool isUpdating;
  final VoidCallback onCancel;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // THẺ STATIONERY CHÍNH
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 10, bottom: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.96),
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(color: Colors.white, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.navySurface.withValues(alpha: 0.08),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: CustomPaint(
                    painter: const StitchedBorderPainter(),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0.95),
                            const Color(0xFFF8FBFF).withValues(alpha: 0.7),
                            const Color(0xFFF2F7FF).withValues(alpha: 0.4),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Phần Avatar với nút camera
                          EditProfileAvatarPicker(user: user),
                          const SizedBox(height: 18),

                          // Nhóm: Thông tin cá nhân
                          const EditProfileSectionTitle(
                            title: 'Thông tin cá nhân',
                            icon: Icons.badge_outlined,
                          ),
                          const SizedBox(height: 10),

                          EditProfileTextField(
                            controller: nameController,
                            label: 'Họ và tên',
                            hint: 'Nguyễn Văn A',
                            prefixIcon: Icons.person_outline_rounded,
                            isRequired: true,
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? 'Vui lòng nhập họ và tên'
                                : null,
                          ),
                          const SizedBox(height: 12),

                          // Chọn giới tính
                          EditProfileGenderSelector(
                            selectedGender: selectedGender,
                            onChanged: onGenderChanged,
                          ),
                          const SizedBox(height: 18),

                          // Nhóm: Thông tin học tập
                          const EditProfileSectionTitle(
                            title: 'Thông tin trường & học tập',
                            icon: Icons.school_outlined,
                          ),
                          const SizedBox(height: 10),

                          EditProfileTextField(
                            controller: studentIdController,
                            label: 'Mã số sinh viên (MSSV)',
                            hint: 'Ví dụ: SE182345',
                            prefixIcon: Icons.tag_rounded,
                          ),
                          const SizedBox(height: 12),

                          EditProfileTextField(
                            controller: universityController,
                            label: 'Trường đại học',
                            hint: 'FPT University',
                            prefixIcon: Icons.account_balance_outlined,
                          ),
                          const SizedBox(height: 12),

                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: EditProfileTextField(
                                  controller: majorController,
                                  label: 'Chuyên ngành',
                                  hint: 'Kỹ thuật phần mềm',
                                  prefixIcon: Icons.computer_rounded,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 2,
                                child: EditProfileTextField(
                                  controller: cohortController,
                                  label: 'Khóa học',
                                  hint: 'K18',
                                  keyboardType: TextInputType.number,
                                  prefixIcon: Icons.layers_outlined,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),

                          // Nhóm: Giới thiệu bản thân
                          const EditProfileSectionTitle(
                            title: 'Giới thiệu bản thân',
                            icon: Icons.format_quote_rounded,
                          ),
                          const SizedBox(height: 10),

                          EditProfileTextField(
                            controller: bioController,
                            label: 'Tiểu sử / Bio',
                            hint:
                                'Chia sẻ đôi dòng về định hướng học tập của bạn...',
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Ghim đỏ 3D Push Pin góc trên bên trái
              const Positioned(top: 0, left: 14, child: PushPinWidget()),

              // Thẻ Sticky Note góc trên bên phải
              const Positioned(
                top: -2,
                right: 2,
                child: ProfileStickyBadge(title: 'Sửa Đổi'),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // HÀNG NÚT: HỦY & LƯU THAY ĐỔI
          EditProfileActionButtons(
            isUpdating: isUpdating,
            onCancel: onCancel,
            onSubmit: onSubmit,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
