import 'dart:async';
import 'dart:convert';
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
  Stream<PaymentStatusModel> subscribePaymentStatus(int orderCode);
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  const PaymentRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<List<SubscriptionPlanModel>> getAvailablePlans() {
    return guardApiCall(() async {
      final response = await _dio.get<Map<String, dynamic>>('/payments/plans');
      final data = response.data?['data'] as List<dynamic>?;
      if (data == null) {
        throw const ParsingException('Không tìm thấy danh sách gói đăng ký.');
      }
      return data
          .map(
            (item) =>
                SubscriptionPlanModel.fromJson(item as Map<String, dynamic>),
          )
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

  @override
  Stream<PaymentStatusModel> subscribePaymentStatus(int orderCode) {
    final cancelToken = CancelToken();
    late final StreamController<PaymentStatusModel> controller;

    controller = StreamController<PaymentStatusModel>(
      onCancel: () {
        if (!cancelToken.isCancelled) {
          cancelToken.cancel();
        }
      },
    );

    _listenToSse(orderCode, controller, cancelToken);

    return controller.stream;
  }

  Future<void> _listenToSse(
    int orderCode,
    StreamController<PaymentStatusModel> controller,
    CancelToken cancelToken,
  ) async {
    try {
      final response = await _dio.get<ResponseBody>(
        '/payments/$orderCode/subscribe',
        options: Options(
          responseType: ResponseType.stream,
          receiveTimeout: Duration.zero,
          headers: const {
            'Accept': 'text/event-stream',
            'Cache-Control': 'no-cache',
          },
        ),
        cancelToken: cancelToken,
      );

      final stream = response.data?.stream;
      if (stream == null) {
        if (!controller.isClosed) await controller.close();
        return;
      }

      String currentEvent = '';
      final lineStream = stream
          .cast<List<int>>()
          .transform(utf8.decoder)
          .transform(const LineSplitter());

      await for (final line in lineStream) {
        if (cancelToken.isCancelled || controller.isClosed) break;

        final trimmed = line.trim();
        if (trimmed.isEmpty) {
          currentEvent = '';
          continue;
        }

        if (trimmed.startsWith('event:')) {
          currentEvent = trimmed.substring(6).trim();
        } else if (trimmed.startsWith('data:')) {
          final data = trimmed.substring(5).trim();
          if (currentEvent == 'PAYMENT_SUCCESS' ||
              trimmed.contains('"status":"PAID"')) {
            try {
              final json = jsonDecode(data) as Map<String, dynamic>;
              final model = PaymentStatusModel.fromJson(json);
              if (!controller.isClosed) {
                controller.add(model);
                await controller.close();
              }
              return;
            } catch (_) {
              // Ignore malformed json payload
            }
          }
        }
      }
      if (!controller.isClosed) await controller.close();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel || cancelToken.isCancelled) {
        if (!controller.isClosed) await controller.close();
        return;
      }
      if (!controller.isClosed) {
        controller.addError(
          ServerException(
            message: e.message ?? 'Lỗi kết nối stream thanh toán',
          ),
        );
        await controller.close();
      }
    } catch (e) {
      if (!controller.isClosed) {
        controller.addError(ServerException(message: e.toString()));
        await controller.close();
      }
    }
  }
}
