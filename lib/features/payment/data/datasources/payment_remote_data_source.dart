import 'package:dio/dio.dart';
import 'package:rental_car/core/error/exceptions.dart';
import 'package:rental_car/core/network/api_handler.dart';
import 'package:rental_car/features/payment/data/models/create_payment_model.dart';
import 'package:rental_car/features/payment/data/models/payment_status_model.dart';
import 'package:rental_car/features/payment/data/models/subscription_plan_model.dart';

abstract interface class PaymentRemoteDataSource {
  Future<List<SubscriptionPlanModel>> getAvailablePlans();
  Future<CreatePaymentModel> createPayment(String planCode);
  Future<PaymentStatusModel> verifyPayment(int orderCode);
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  const PaymentRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<List<SubscriptionPlanModel>> getAvailablePlans() {
    return guardApiCall(() async {
      final response =
          await _dio.get<Map<String, dynamic>>('/payments/plans');
      final data = response.data?['data'] as List<dynamic>?;
      if (data == null) {
        throw const ParsingException('Không tìm thấy danh sách gói đăng ký.');
      }
      return data
          .map((item) =>
              SubscriptionPlanModel.fromJson(item as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<CreatePaymentModel> createPayment(String planCode) {
    return guardApiCall(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        '/payments/checkout',
        data: {'plan': planCode},
      );
      final data = response.data?['data'] as Map<String, dynamic>?;
      if (data == null) {
        throw const ParsingException('Lỗi tạo đơn thanh toán.');
      }
      return CreatePaymentModel.fromJson(data);
    });
  }

  @override
  Future<PaymentStatusModel> verifyPayment(int orderCode) {
    return guardApiCall(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        '/payments/$orderCode/verify',
      );
      final data = response.data?['data'] as Map<String, dynamic>?;
      if (data == null) {
        throw const ParsingException('Lỗi xác thực trạng thái thanh toán.');
      }
      return PaymentStatusModel.fromJson(data);
    });
  }
}
