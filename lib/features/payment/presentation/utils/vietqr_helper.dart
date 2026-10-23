/// Helper utility to parse EMVCo VietQR payload and generate bank app deeplinks.
abstract final class VietqrHelper {
  /// Maps NAPAS BIN codes to readable bank names and short IDs.
  static const Map<String, String> binToBankName = {
    '970422': 'MBBank (Quân Đội)',
    '970436': 'Vietcombank',
    '970407': 'Techcombank',
    '970416': 'ACB',
    '970432': 'VPBank',
    '970423': 'TPBank',
    '970418': 'BIDV',
    '970405': 'Agribank',
    '970415': 'VietinBank',
    '970454': 'Timo (BVBank)',
    '546034': 'CAKE by VPBank',
    '970429': 'SCB',
    '970448': 'OCB',
    '970443': 'SHB',
    '970425': 'ABBANK',
    '970431': 'Eximbank',
    '970426': 'MSB',
    '970403': 'Sacombank',
    '970441': 'VIB',
  };

  /// Parses a raw EMVCo VietQR string into structured [VietQrInfo].
  static VietQrInfo parse(String? qrCode) {
    if (qrCode == null || qrCode.isEmpty) {
      return const VietQrInfo();
    }

    try {
      final rootTags = _parseTlv(qrCode);

      String? bin;
      String? accountNumber;

      // Tag 38 hoặc Tag 26: Merchant Account Information cho VietQR / NAPAS
      final merchantTag = rootTags['38'] ?? rootTags['26'];
      if (merchantTag != null) {
        final subTags = _parseTlv(merchantTag);
        // Subtag 01 contains beneficiary bank info (subtag 00: BIN, subtag 01: Account number)
        final tag01 = subTags['01'];
        if (tag01 != null) {
          final beneficiary = _parseTlv(tag01);
          bin = beneficiary['00'];
          accountNumber = beneficiary['01'];
        }
      }

      // Tag 54: Transaction amount
      int? amount;
      final amountStr = rootTags['54'];
      if (amountStr != null) {
        amount = int.tryParse(amountStr);
      }

      // Tag 62: Additional Data Template (subtag 08: Purpose of transaction / reference)
      String? description;
      final tag62 = rootTags['62'];
      if (tag62 != null) {
        final subTags62 = _parseTlv(tag62);
        description = subTags62['08'] ?? subTags62['01'];
      }

      final bankName = bin != null ? binToBankName[bin] : null;

      return VietQrInfo(
        bin: bin,
        accountNumber: accountNumber,
        amount: amount,
        description: description,
        bankName: bankName,
      );
    } catch (_) {
      return const VietQrInfo();
    }
  }

  /// Builds a VietQR universal deeplink URL (`https://dl.vietqr.io/pay?...`).
  ///
  /// VietQR's deeplink service recognizes the target banking app via [appId],
  /// and prefills transfer details using [accountNumber], [bin], [amount], and [orderCode].
  static String buildDeeplink({
    required String appId,
    String? accountNumber,
    String? bin,
    int? amount,
    int? orderCode,
  }) {
    final queryParams = <String, String>{'app': appId};

    if (accountNumber != null &&
        bin != null &&
        accountNumber.isNotEmpty &&
        bin.isNotEmpty) {
      queryParams['ba'] = '$accountNumber@$bin';
    }

    if (amount != null && amount > 0) {
      queryParams['am'] = amount.toString();
    }

    if (orderCode != null) {
      queryParams['tn'] = 'NEXTUNITY $orderCode';
    }

    return Uri.https('dl.vietqr.io', '/pay', queryParams).toString();
  }

  static Map<String, String> _parseTlv(String s) {
    final result = <String, String>{};
    int i = 0;
    while (i + 4 <= s.length) {
      final tag = s.substring(i, i + 2);
      final len = int.tryParse(s.substring(i + 2, i + 4)) ?? 0;
      i += 4;
      if (i + len <= s.length) {
        result[tag] = s.substring(i, i + len);
        i += len;
      } else {
        break;
      }
    }
    return result;
  }
}

/// Structured payment metadata parsed from a VietQR code.
class VietQrInfo {
  const VietQrInfo({
    this.bin,
    this.accountNumber,
    this.amount,
    this.description,
    this.bankName,
  });

  final String? bin;
  final String? accountNumber;
  final int? amount;
  final String? description;
  final String? bankName;
}
