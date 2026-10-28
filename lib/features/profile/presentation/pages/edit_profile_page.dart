import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/core/providers/core_providers.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/profile/presentation/providers/profile_providers.dart';
import 'package:rental_car/features/profile/presentation/widgets/decorations/origami_decor_painter.dart';
import 'package:rental_car/features/profile/presentation/widgets/edit/edit_profile_form.dart';
import 'package:rental_car/features/profile/presentation/widgets/edit/edit_profile_top_bar.dart';
import 'package:rental_car/features/profile/presentation/widgets/edit/profile_detail_view.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  bool _isEditing = false;

  late final TextEditingController _nameController;
  late final TextEditingController _studentIdController;
  late final TextEditingController _universityController;
  late final TextEditingController _majorController;
  late final TextEditingController _cohortController;
  late final TextEditingController _bioController;

  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(currentUserProvider);

    _nameController = TextEditingController(text: profile?.fullName ?? '');
    _studentIdController = TextEditingController(
      text: profile?.studentId ?? '',
    );
    _universityController = TextEditingController(
      text: profile?.university ?? 'FPT University',
    );
    _majorController = TextEditingController(text: profile?.major ?? '');
    _cohortController = TextEditingController(
      text: profile?.cohort != null ? '${profile!.cohort}' : '',
    );
    _bioController = TextEditingController(text: profile?.bio ?? '');
    _selectedGender = profile?.gender ?? 'MALE';
  }

  void _syncControllersWithProfile() {
    final profile = ref.read(currentUserProvider);
    _nameController.text = profile?.fullName ?? '';
    _studentIdController.text = profile?.studentId ?? '';
    _universityController.text = profile?.university ?? 'FPT University';
    _majorController.text = profile?.major ?? '';
    _cohortController.text = profile?.cohort != null
        ? '${profile!.cohort}'
        : '';
    _bioController.text = profile?.bio ?? '';
    _selectedGender = profile?.gender ?? 'MALE';
  }

  void _cancelEdit() {
    _syncControllersWithProfile();
    setState(() => _isEditing = false);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _studentIdController.dispose();
    _universityController.dispose();
    _majorController.dispose();
    _cohortController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final cohortNum = int.tryParse(_cohortController.text.trim());

    final success = await ref
        .read(profileControllerProvider.notifier)
        .updateProfile(
          fullName: _nameController.text.trim(),
          university: _universityController.text.trim(),
          studentId: _studentIdController.text.trim(),
          major: _majorController.text.trim().isNotEmpty
              ? _majorController.text.trim()
              : null,
          cohort: cohortNum,
          gender: _selectedGender,
          bio: _bioController.text.trim(),
        );

    if (mounted) {
      if (success) {
        context.showSnackBar(
          'Cập nhật thông tin hồ sơ thành công!',
          type: SnackType.success,
        );
        setState(() => _isEditing = false);
      } else {
        final error =
            ref.read(profileControllerProvider).errorMessage ??
            'Cập nhật thất bại. Vui lòng kiểm tra lại kết nối!';
        context.showSnackBar(error, type: SnackType.error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileControllerProvider);
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: AppColors.pastelBackground,
      body: Stack(
        children: [
          // Background Origami Decor
          const Positioned(
            top: 40,
            left: -15,
            child: Opacity(
              opacity: 0.3,
              child: CustomPaint(
                size: Size(90, 90),
                painter: OrigamiDecorPainter(),
              ),
            ),
          ),
          Positioned(
            top: 120,
            right: -20,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryBorder.withValues(alpha: 0.35),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // 1. TOP APP BAR
                EditProfileTopBar(
                  isEditing: _isEditing,
                  isUpdating: state.isUpdating,
                  onBack: () => context.pop(),
                  onCancel: _cancelEdit,
                  onStartEdit: () {
                    _syncControllersWithProfile();
                    setState(() => _isEditing = true);
                  },
                  onSave: _submit,
                ),

                // 2. NỘI DUNG CUỘN ĐƯỢC (CHẾ ĐỘ XEM HOẶC CHẾ ĐỘ SỬA)
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    child: !_isEditing
                        ? ProfileDetailView(
                            user: user,
                            onEdit: () {
                              _syncControllersWithProfile();
                              setState(() => _isEditing = true);
                            },
                          )
                        : EditProfileForm(
                            formKey: _formKey,
                            user: user,
                            nameController: _nameController,
                            studentIdController: _studentIdController,
                            universityController: _universityController,
                            majorController: _majorController,
                            cohortController: _cohortController,
                            bioController: _bioController,
                            selectedGender: _selectedGender,
                            onGenderChanged: (gender) {
                              setState(() => _selectedGender = gender);
                            },
                            isUpdating: state.isUpdating,
                            onCancel: _cancelEdit,
                            onSubmit: _submit,
                          ),
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
