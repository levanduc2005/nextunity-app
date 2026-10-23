import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gal/gal.dart';
import 'package:intl/intl.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/auth/presentation/providers/auth_controller.dart';
import 'package:rental_car/features/payment/domain/entities/payment_result_entity.dart';
import 'package:rental_car/features/payment/domain/entities/payment_status_entity.dart';
import 'package:rental_car/features/payment/presentation/constants/supported_banks.dart';
import 'package:rental_car/features/payment/presentation/providers/payment_providers.dart';
import 'package:rental_car/features/payment/presentation/utils/vietqr_helper.dart';
import 'package:rental_car/features/payment/presentation/widgets/checkout/bank_app_grid.dart';
import 'package:rental_car/features/payment/presentation/widgets/checkout/payment_empty_state_view.dart';
import 'package:rental_car/features/payment/presentation/widgets/checkout/payment_expired_view.dart';
import 'package:rental_car/features/payment/presentation/widgets/checkout/payment_method_option_card.dart';
import 'package:rental_car/features/payment/presentation/widgets/checkout/payment_order_summary_card.dart';
import 'package:rental_car/features/payment/presentation/widgets/checkout/payment_page_app_bar.dart';
import 'package:rental_car/features/payment/presentation/widgets/checkout/vietqr_display_card.dart';
import 'package:rental_car/features/payment/presentation/widgets/common/payment_trust_badges.dart';
import 'package:rental_car/features/payment/presentation/widgets/dialogs/payment_success_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

/// Full-page payment checkout screen for NextUnity Plus.
/// Supports direct Bank App deeplink (Option 1) and VietQR scanning (Option 2)
/// with real-time payment auto-polling.
class PaymentPage extends ConsumerStatefulWidget {
  const PaymentPage({
    super.key,
    this.paymentResult,
    this.planName = 'Gói NextUnity Plus',
  });

  final PaymentResultEntity? paymentResult;
  final String planName;

  @override
  ConsumerState<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends ConsumerState<PaymentPage>
    with WidgetsBindingObserver {
  String _selectedOption = 'bank';
  String _selectedBankName = 'MBBank';
  String _selectedBankId = 'mbbank';

  Timer? _countdownTimer;
  StreamSubscription<PaymentStatusEntity>? _sseSubscription;
  late int _secondsLeft;
  PaymentResultEntity? _currentPayment;

  final currencyFormatter = NumberFormat('#,###', 'vi_VN');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _currentPayment = widget.paymentResult;
    _secondsLeft = _calculateInitialSeconds();
    if (_currentPayment != null && _secondsLeft > 0) {
      _startCountdown();
      _subscribePaymentRealtime();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _countdownTimer?.cancel();
    _sseSubscription?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _secondsLeft > 0) {
      // Khi người dùng quay lại từ app ngân hàng: kiểm tra ngay 1 lần duy nhất
      _checkPaymentStatusSilently();
    }
  }

  int _calculateInitialSeconds() {
    final expiresAt = _currentPayment?.expiresAt;
    if (expiresAt != null) {
      final diff = expiresAt.toLocal().difference(DateTime.now()).inSeconds;
      return diff > 0 ? diff : 0;
    }
    return 14 * 60 + 59;
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft <= 0) {
        timer.cancel();
        _sseSubscription?.cancel();
        if (mounted) {
          setState(() => _secondsLeft = 0);
        }
      } else {
        if (mounted) {
          setState(() => _secondsLeft--);
        }
      }
    });
  }

  void _subscribePaymentRealtime() {
    final payment = _currentPayment;
    if (payment == null) return;

    _sseSubscription?.cancel();
    _sseSubscription = ref
        .read(paymentControllerProvider.notifier)
        .subscribePayment(payment.orderCode)
        .listen(
          (status) {
            if (status.isPaid) {
              _handlePaymentSuccess();
            }
          },
          onError: (_) {
            // SSE đứt kết nối do mạng, sẽ tự phục hồi qua lifecycle resumed
          },
        );
  }

  Future<void> _checkPaymentStatusSilently() async {
    final payment = _currentPayment;
    if (payment == null) return;

    final status = await ref
        .read(paymentControllerProvider.notifier)
        .verifyPayment(payment.orderCode);
    if (status != null && status.isPaid) {
      _handlePaymentSuccess();
    }
  }

  void _handlePaymentSuccess() {
    _countdownTimer?.cancel();
    _sseSubscription?.cancel();
    if (mounted) {
      ref.read(authControllerProvider.notifier).checkAuthStatus();
      showPaymentSuccessDialog(context, planName: widget.planName);
    }
  }

  Future<void> _openBankApp() async {
    final payment = _currentPayment;
    if (payment == null) return;

    // 1. Tự động sao chép mã nội dung chuyển khoản vào Clipboard
    final orderCodeText = 'NEXTUNITY ${payment.orderCode}';
    Clipboard.setData(ClipboardData(text: orderCodeText));

    final bank = SupportedBanks.findById(_selectedBankId);
    final bankName = bank?['name'] as String? ?? 'Ngân hàng';
    final appId = bank?['appId'] as String?;
    final scheme = bank?['scheme'] as String?;

    if (mounted) {
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

    // 2. Nếu universal link không mở được, thử mở trực tiếp qua custom scheme của app ngân hàng
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

    // 3. Fallback: Nếu thiết bị chưa cài app ngân hàng đó, điều hướng sang web checkout PayOS
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

    if (!launched && mounted) {
      context.showSnackBar(
        'Không thể mở ứng dụng ngân hàng. Vui lòng quét mã QR hoặc chuyển khoản theo thông tin bên dưới.',
      );
    }
  }

  Future<void> _handleSaveQr(String qrImageUrl) async {
    final payment = _currentPayment;
    if (payment == null) return;

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

        if (mounted) {
          context.showSnackBar(
            'Đã lưu ảnh mã QR vào Thư viện ảnh! Bạn có thể mở app ngân hàng chọn "Quét QR từ ảnh" để thanh toán.',
          );
        }
        return;
      }
      throw Exception('Không tải được dữ liệu ảnh');
    } on MissingPluginException {
      if (mounted) {
        context.showSnackBar(
          'Vui lòng khởi động lại app (Stop & Run lại) để kích hoạt thư viện lưu ảnh vào máy.',
        );
      }
    } on GalException catch (e) {
      if (mounted) {
        context.showSnackBar(
          'Không thể lưu vào thư viện (${e.type.message}). Vui lòng cấp quyền Thư viện ảnh cho app!',
        );
      }
    } catch (e) {
      if (mounted) {
        context.showSnackBar(
          'Không thể lưu ảnh QR ($e). Đã sao chép mã VietQR vào bộ nhớ tạm!',
        );
      }
    }
  }

  String _formatTimer() {
    if (_secondsLeft <= 0) return 'Đã hết hạn';
    final mins = _secondsLeft ~/ 60;
    final secs = _secondsLeft % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final payment = _currentPayment;

    if (payment == null) {
      return const PaymentEmptyStateView();
    }

    final amountFormatted = currencyFormatter.format(payment.amount);

    if (_secondsLeft <= 0) {
      return PaymentExpiredView(
        planName: widget.planName,
        orderCode: payment.orderCode,
        amountFormatted: amountFormatted,
      );
    }

    final qrImageUrl =
        'https://api.qrserver.com/v1/create-qr-code/?size=320x320&data=${Uri.encodeComponent(payment.qrCode)}';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const PaymentPageAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PaymentOrderSummaryCard(
              planName: widget.planName,
              orderCode: payment.orderCode,
              amountFormatted: amountFormatted,
              formattedTimer: _formatTimer(),
            ),
            const SizedBox(height: 18),

            const Text(
              'Chọn phương thức thanh toán:',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 10),

            // Option 1: Mở app ngân hàng (Deeplink)
            PaymentMethodOptionCard(
              title: 'Mở ứng dụng Ngân hàng',
              badge: 'Chuyển nhanh',
              subtitle:
                  'Mở app banking bạn đang dùng. Hệ thống sẽ tự động sao chép mã đơn hàng để bạn dán nếu app chưa tự điền.',
              isSelected: _selectedOption == 'bank',
              onTap: () => setState(() => _selectedOption = 'bank'),
              child: BankAppGrid(
                banks: SupportedBanks.list,
                selectedBankId: _selectedBankId,
                selectedBankName: _selectedBankName,
                onSelectBank: (id, name) {
                  setState(() {
                    _selectedBankId = id;
                    _selectedBankName = name;
                  });
                },
                onOpenBankApp: _openBankApp,
              ),
            ),
            const SizedBox(height: 14),

            // Option 2: Quét mã VietQR
            PaymentMethodOptionCard(
              title: 'Quét mã VietQR',
              badge: 'Chụp/Lưu mã',
              subtitle:
                  'Dành cho quét từ thiết bị khác hoặc lưu ảnh QR vào thư viện',
              isSelected: _selectedOption == 'qr',
              onTap: () => setState(() => _selectedOption = 'qr'),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: VietQrDisplayCard(
                  qrImageUrl: qrImageUrl,
                  onSaveQr: () => _handleSaveQr(qrImageUrl),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Trust Badges
            const PaymentTrustBadges(),
          ],
        ),
      ),
    );
  }
}
