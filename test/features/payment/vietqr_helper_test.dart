import 'package:flutter_test/flutter_test.dart';
import 'package:rental_car/features/payment/presentation/constants/supported_banks.dart';
import 'package:rental_car/features/payment/presentation/utils/vietqr_helper.dart';

void main() {
  group('VietqrHelper Tests', () {
    test('parses null or empty qrCode safely', () {
      final nullInfo = VietqrHelper.parse(null);
      expect(nullInfo.bin, isNull);
      expect(nullInfo.accountNumber, isNull);
      expect(nullInfo.bankName, isNull);

      final emptyInfo = VietqrHelper.parse('');
      expect(emptyInfo.bin, isNull);
      expect(emptyInfo.accountNumber, isNull);
    });

    test('parses valid EMVCo VietQR string correctly', () {
      const sampleQr =
          '00020101021238560010A0000007270126000697042201121133666688880208QRIBFTTA530370454061000005802VN62230819THANH TOAN DON HANG6304BE36';

      final info = VietqrHelper.parse(sampleQr);
      expect(info.bin, '970422');
      expect(info.accountNumber, '113366668888');
      expect(info.bankName, 'MBBank (Quân Đội)');
      expect(info.amount, 100000);
      expect(info.description, 'THANH TOAN DON HANG');
    });

    test('buildDeeplink generates correct VietQR URL format', () {
      final url = VietqrHelper.buildDeeplink(
        appId: 'mb',
        accountNumber: '113366668888',
        bin: '970422',
        amount: 49000,
        orderCode: 998877,
      );

      final uri = Uri.parse(url);
      expect(uri.scheme, 'https');
      expect(uri.host, 'dl.vietqr.io');
      expect(uri.path, '/pay');
      expect(uri.queryParameters['app'], 'mb');
      expect(uri.queryParameters['ba'], '113366668888@970422');
      expect(uri.queryParameters['am'], '49000');
      expect(uri.queryParameters['tn'], 'NEXTUNITY 998877');
    });

    test('buildDeeplink handles missing optional fields gracefully', () {
      final url = VietqrHelper.buildDeeplink(appId: 'vcb');
      final uri = Uri.parse(url);
      expect(uri.queryParameters['app'], 'vcb');
      expect(uri.queryParameters.containsKey('ba'), isFalse);
      expect(uri.queryParameters.containsKey('am'), isFalse);
    });
  });

  group('SupportedBanks Tests', () {
    test('contains 8 banks with required metadata', () {
      expect(SupportedBanks.list.length, 8);
      for (final bank in SupportedBanks.list) {
        expect(bank['id'], isNotNull);
        expect(bank['name'], isNotNull);
        expect(bank['short'], isNotNull);
        expect(bank['color'], isNotNull);
        expect(bank['appId'], isNotNull);
        expect(bank['scheme'], isNotNull);
        expect(bank['package'], isNotNull);
      }
    });

    test('findById returns bank correctly', () {
      final mb = SupportedBanks.findById('mbbank');
      expect(mb, isNotNull);
      expect(mb?['name'], 'MBBank');
      expect(mb?['appId'], 'mb');
      expect(mb?['scheme'], 'mbbank');

      final unknown = SupportedBanks.findById('non_existing');
      expect(unknown, isNull);
    });
  });
}
