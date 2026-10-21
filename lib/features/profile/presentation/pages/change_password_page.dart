import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/profile/presentation/providers/profile_providers.dart';
import 'package:rental_car/features/profile/presentation/widgets/change_password/change_password_notebook_card.dart';
import 'package:rental_car/features/profile/presentation/widgets/change_password/change_password_step1_form.dart';
import 'package:rental_car/features/profile/presentation/widgets/change_password/change_password_step2_form.dart';
import 'package:rental_car/features/profile/presentation/widgets/change_password/change_password_top_bar.dart';
import 'package:rental_car/features/profile/presentation/widgets/decorations/origami_decor_painter.dart';

/// Màn hình Đổi mật khẩu trong Profile (yêu cầu Access Token).
/// - Bước 1: Nhập mật khẩu hiện tại, gửi về BE /users/check-password để xác thực.
/// - Bước 2: Khi mật khẩu cũ chính xác, hiển thị 2 ô nhập mật khẩu mới và xác nhận mật khẩu.
class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ConsumerState<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  // 0: Bước kiểm tra mật khẩu hiện tại
  // 1: Bước nhập mật khẩu mới và xác nhận
  int _step = 0;
  bool _isLoading = false;

  final _step1FormKey = GlobalKey<FormState>();
  final _step2FormKey = GlobalKey<FormState>();

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _checkedCurrentPassword = '';

  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(() => setState(() {}));
    _confirmPasswordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _hasMin8Chars => _newPasswordController.text.length >= 8;
  bool get _hasUpperAndLower {
    final text = _newPasswordController.text;
    return text.contains(RegExp(r'[A-Z]')) && text.contains(RegExp(r'[a-z]'));
  }

  bool get _hasNumber => _newPasswordController.text.contains(RegExp(r'[0-9]'));
  bool get _isPasswordValid => _hasMin8Chars && _hasUpperAndLower && _hasNumber;

  // Bước 1: Gửi mật khẩu hiện tại về BE để kiểm tra
  Future<void> _handleCheckCurrentPassword() async {
    if (!_step1FormKey.currentState!.validate()) return;

    final password = _currentPasswordController.text;

    setState(() => _isLoading = true);

    final result = await ref.read(checkPasswordUseCaseProvider).call(password);

    if (!mounted) return;
    setState(() => _isLoading = false);

    result.when(
      ok: (_) {
        _checkedCurrentPassword = password;
        setState(() => _step = 1);
        context.showSnackBar(
          'Mật khẩu hiện tại chính xác. Vui lòng nhập mật khẩu mới!',
          type: SnackType.success,
        );
      },
      err: (failure) {
        context.showSnackBar(
          failure.message.isNotEmpty
              ? failure.message
              : 'Mật khẩu hiện tại không chính xác. Vui lòng kiểm tra lại!',
          type: SnackType.error,
        );
      },
    );
  }

  // Bước 2: Gửi mật khẩu mới và mật khẩu cũ lên BE để cập nhật
  Future<void> _handleChangePassword() async {
    if (!_step2FormKey.currentState!.validate()) return;

    if (!_isPasswordValid) {
      context.showSnackBar(
        'Mật khẩu mới chưa đáp ứng đầy đủ tiêu chuẩn bảo mật',
        type: SnackType.error,
      );
      return;
    }

    final newPassword = _newPasswordController.text;

    if (newPassword == _checkedCurrentPassword) {
      context.showSnackBar(
        'Mật khẩu mới không được trùng với mật khẩu hiện tại',
        type: SnackType.error,
      );
      return;
    }

    setState(() => _isLoading = true);

    final result = await ref
        .read(changePasswordUseCaseProvider)
        .call(
          currentPassword: _checkedCurrentPassword,
          newPassword: newPassword,
        );

    if (!mounted) return;
    setState(() => _isLoading = false);

    result.when(
      ok: (_) {
        context.showSnackBar(
          'Đổi mật khẩu thành công!',
          type: SnackType.success,
        );
        context.pop();
      },
      err: (failure) {
        context.showSnackBar(
          failure.message.isNotEmpty
              ? failure.message
              : 'Đổi mật khẩu thất bại. Vui lòng thử lại!',
          type: SnackType.error,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pastelBackground,
      body: Stack(
        children: [
          // Background Origami Decor
          const Positioned(
            top: 40,
            left: -15,
            child: Opacity(
              opacity: 0.35,
              child: CustomPaint(
                size: Size(90, 90),
                painter: OrigamiDecorPainter(),
              ),
            ),
          ),
          Positioned(
            top: 110,
            right: -20,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFBFDBFE).withValues(alpha: 0.35),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                ChangePasswordTopBar(
                  step: _step,
                  onBackStep: () => setState(() => _step = 0),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    child: ChangePasswordNotebookCard(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: _step == 0
                            ? ChangePasswordStep1Form(
                                formKey: _step1FormKey,
                                currentPasswordController:
                                    _currentPasswordController,
                                isLoading: _isLoading,
                                onSubmit: _handleCheckCurrentPassword,
                              )
                            : ChangePasswordStep2Form(
                                formKey: _step2FormKey,
                                newPasswordController: _newPasswordController,
                                confirmPasswordController:
                                    _confirmPasswordController,
                                hasMin8Chars: _hasMin8Chars,
                                hasUpperAndLower: _hasUpperAndLower,
                                hasNumber: _hasNumber,
                                isLoading: _isLoading,
                                onBack: () => setState(() => _step = 0),
                                onSubmit: _handleChangePassword,
                              ),
                      ),
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
