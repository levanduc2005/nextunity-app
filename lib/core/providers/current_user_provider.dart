import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/features/auth/domain/entities/user_entity.dart';
import 'package:rental_car/features/auth/presentation/providers/auth_controller.dart';

/// Nguồn chân lý duy nhất (Single Source of Truth) cho thông tin người dùng đang đăng nhập trên toàn ứng dụng.
///
/// Sử dụng .select((s) => s.user) để tối ưu hiệu năng: các widget lắng nghe provider này
/// chỉ rebuild khi thông tin User thực sự thay đổi, không bị ảnh hưởng bởi isLoading hay errorMessage.
final currentUserProvider = Provider<UserEntity?>((ref) {
  return ref.watch(authControllerProvider.select((s) => s.user));
});
