import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/auth/presentation/providers/auth_controller.dart';
import 'package:rental_car/features/payment/domain/entities/payment_result_entity.dart';
import 'package:rental_car/features/payment/domain/entities/payment_status_entity.dart';
import 'package:rental_car/features/payment/presentation/constants/supported_banks.dart';
import 'package:rental_car/features/payment/presentation/providers/payment_providers.dart';
import 'package:rental_car/features/payment/presentation/widgets/checkout/bank_app_grid.dart';
import 'package:rental_car/features/payment/presentation/widgets/checkout/bank_transfer_info_card.dart';
import 'package:rental_car/features/payment/presentation/widgets/checkout/payment_empty_state_view.dart';
import 'package:rental_car/features/payment/presentation/widgets/checkout/payment_expired_view.dart';
import 'package:rental_car/features/payment/presentation/widgets/checkout/payment_manual_verify_button.dart';
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
  bool _isChecking = false;
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

    final checkoutUri = Uri.tryParse(payment.checkoutUrl);
    if (checkoutUri != null) {
      try {
        final launched = await launchUrl(
          checkoutUri,
          mode: LaunchMode.externalApplication,
        );
        if (!launched && mounted) {
          context.showSnackBar(
            'Vui lòng quét mã QR hoặc chuyển khoản theo thông tin bên dưới.',
          );
        }
      } catch (e) {
        if (mounted) {
          context.showSnackBar('Lỗi mở ứng dụng ngân hàng: $e');
        }
      }
    }
  }

  Future<void> _manualVerify() async {
    final payment = _currentPayment;
    if (payment == null) return;

    setState(() => _isChecking = true);
    final status = await ref
        .read(paymentControllerProvider.notifier)
        .verifyPayment(payment.orderCode);
    if (mounted) {
      setState(() => _isChecking = false);
    }

    if (status != null && status.isPaid) {
      _handlePaymentSuccess();
    } else {
      if (mounted) {
        context.showSnackBar(
          'Hệ thống đang kiểm tra tiền vào tài khoản. Vui lòng đợi trong giây lát!',
        );
      }
    }
  }

  void _copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    context.showSnackBar('Đã sao chép $label');
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

    final orderCodeStr = 'NEXTUNITY ${payment.orderCode}';
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
              badge: 'Tự điền form',
              subtitle:
                  'Mở app banking bạn đang dùng và tự động điền STK, số tiền, nội dung',
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
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  VietQrDisplayCard(
                    qrImageUrl: qrImageUrl,
                    onOpenCheckoutUrl: _openBankApp,
                  ),
                  const SizedBox(height: 12),
                  BankTransferInfoCard(
                    amountFormatted: amountFormatted,
                    orderCode: orderCodeStr,
                    onCopy: _copyToClipboard,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Confirm manual verify button
            PaymentManualVerifyButton(
              isChecking: _isChecking,
              onPressed: _manualVerify,
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
