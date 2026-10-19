import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rental_car/features/auth/domain/entities/auth_tokens.dart';

part 'auth_tokens_model.freezed.dart';
part 'auth_tokens_model.g.dart';

@freezed
abstract class AuthTokensModel with _$AuthTokensModel {
  const factory AuthTokensModel({
    required String accessToken,
    String? refreshToken,
  }) = _AuthTokensModel;

  const AuthTokensModel._();

  factory AuthTokensModel.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensModelFromJson(json);

  AuthTokens toEntity() {
    return AuthTokens(accessToken: accessToken, refreshToken: refreshToken);
  }
}
