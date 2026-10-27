import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gal/gal.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/payment/domain/entities/payment_result_entity.dart';
import 'package:rental_car/features/payment/presentation/constants/supported_banks.dart';
import 'package:rental_car/features/payment/presentation/utils/vietqr_helper.dart';
import 'package:url_launcher/url_launcher.dart';

/// Tiện ích hỗ trợ mở ứng dụng ngân hàng và lưu mã QR thanh toán vào thư viện ảnh
class PaymentActionHelper {
  const PaymentActionHelper._();

  /// Mở ứng dụng ngân hàng được chọn hoặc chuyển sang web thanh toán PayOS
  static Future<void> openBankApp(
    BuildContext context, {
    required PaymentResultEntity payment,
    required String selectedBankId,
  }) async {
    // 1. Tự động sao chép mã nội dung chuyển khoản vào Clipboard
    final orderCodeText = 'NEXTUNITY ${payment.orderCode}';
    Clipboard.setData(ClipboardData(text: orderCodeText));

    final bank = SupportedBanks.findById(selectedBankId);
    final bankName = bank?['name'] as String? ?? 'Ngân hàng';
    final appId = bank?['appId'] as String?;
    final scheme = bank?['scheme'] as String?;

    if (context.mounted) {
      context.showSnackBar(
        'Đã sao chép nội dung: "$orderCodeText". Vui lòng dán vào ô nội dung trong app $bankName nếu chưa tự điền!',
      );
    }

    final qrInfo = VietqrHelper.parse(payment.qrCode);
    bool launched = false;

    // 2. Thử mở trực tiếp app ngân hàng bằng VietQR universal deeplink
    if (appId != null) {
      final deeplinkUrl = VietqrHelper.buildDeeplink(
        appId: appId,
        accountNumber: qrInfo.accountNumber,
        bin: qrInfo.bin,
        amount: payment.amount,
        orderCode: payment.orderCode,
      );
      final deeplinkUri = Uri.tryParse(deeplinkUrl);
      if (deeplinkUri != null) {
        try {
          launched = await launchUrl(
            deeplinkUri,
            mode: LaunchMode.externalApplication,
          );
        } catch (_) {
          launched = false;
        }
      }
    }

    // 3. Nếu universal link không mở được, thử mở trực tiếp qua custom scheme của app ngân hàng
    if (!launched && scheme != null) {
      final schemeUri = Uri.tryParse('$scheme://');
      if (schemeUri != null) {
        try {
          if (await canLaunchUrl(schemeUri)) {
            launched = await launchUrl(
              schemeUri,
              mode: LaunchMode.externalApplication,
            );
          }
        } catch (_) {
          launched = false;
        }
      }
    }

    // 4. Fallback: Nếu thiết bị chưa cài app ngân hàng đó, điều hướng sang web checkout PayOS
    if (!launched) {
      final checkoutUri = Uri.tryParse(payment.checkoutUrl);
      if (checkoutUri != null) {
        try {
          launched = await launchUrl(
            checkoutUri,
            mode: LaunchMode.externalApplication,
          );
        } catch (_) {
          launched = false;
        }
      }
    }

    if (!launched && context.mounted) {
      context.showSnackBar(
        'Không thể mở ứng dụng ngân hàng. Vui lòng quét mã QR hoặc chuyển khoản theo thông tin bên dưới.',
      );
    }
  }

  /// Tải và lưu ảnh mã QR thanh toán vào thư viện ảnh thiết bị
  static Future<void> saveQrToGallery(
    BuildContext context, {
    required PaymentResultEntity payment,
    required String qrImageUrl,
  }) async {
    Clipboard.setData(ClipboardData(text: payment.qrCode));

    try {
      final response = await Dio().get<List<int>>(
        qrImageUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      final bytes = response.data;
      if (bytes != null && bytes.isNotEmpty) {
        await Gal.putImageBytes(
          Uint8List.fromList(bytes),
          name: 'nextunity_qr_${payment.orderCode}',
        );

        if (context.mounted) {
          context.showSnackBar(
            'Đã lưu ảnh mã QR vào Thư viện ảnh! Bạn có thể mở app ngân hàng chọn "Quét QR từ ảnh" để thanh toán.',
          );
        }
        return;
      }
      throw Exception('Không tải được dữ liệu ảnh');
    } on MissingPluginException {
      if (context.mounted) {
        context.showSnackBar(
          'Vui lòng khởi động lại app để kích hoạt thư viện lưu ảnh vào máy.',
        );
      }
    } on GalException catch (e) {
      if (context.mounted) {
        context.showSnackBar(
          'Không thể lưu vào thư viện (${e.type.message}). Vui lòng cấp quyền Thư viện ảnh cho app!',
        );
      }
    } catch (e) {
      if (context.mounted) {
        context.showSnackBar(
          'Không thể lưu ảnh QR ($e). Đã sao chép mã VietQR vào bộ nhớ tạm!',
        );
      }
    }
  }
}
