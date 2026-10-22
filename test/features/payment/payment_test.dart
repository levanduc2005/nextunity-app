import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rental_car/core/error/exceptions.dart';
import 'package:rental_car/core/error/failure.dart';
import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/payment/data/datasources/payment_remote_data_source.dart';
import 'package:rental_car/features/payment/data/models/create_payment_model.dart';
import 'package:rental_car/features/payment/data/models/payment_status_model.dart';
import 'package:rental_car/features/payment/data/models/subscription_plan_model.dart';
import 'package:rental_car/features/payment/data/repositories/payment_repository_impl.dart';
import 'package:rental_car/features/payment/domain/entities/payment_result_entity.dart';
import 'package:rental_car/features/payment/domain/entities/payment_status_entity.dart';
import 'package:rental_car/features/payment/domain/entities/subscription_plan_entity.dart';
import 'package:rental_car/features/payment/domain/repositories/payment_repository.dart';
import 'package:rental_car/features/payment/domain/usecases/create_payment_use_case.dart';
import 'package:rental_car/features/payment/domain/usecases/get_available_plans_use_case.dart';
import 'package:rental_car/features/payment/domain/usecases/subscribe_payment_status_use_case.dart';
import 'package:rental_car/features/payment/domain/usecases/verify_payment_use_case.dart';

class MockPaymentRepository extends Mock implements PaymentRepository {}
class MockPaymentRemoteDataSource extends Mock implements PaymentRemoteDataSource {}

void main() {
  group('Payment Feature Use Cases', () {
    late MockPaymentRepository repository;
    late GetAvailablePlansUseCase getAvailablePlansUseCase;
    late CreatePaymentUseCase createPaymentUseCase;
    late VerifyPaymentUseCase verifyPaymentUseCase;
    late SubscribePaymentStatusUseCase subscribePaymentStatusUseCase;

    setUp(() {
      repository = MockPaymentRepository();
      getAvailablePlansUseCase = GetAvailablePlansUseCase(repository);
      createPaymentUseCase = CreatePaymentUseCase(repository);
      verifyPaymentUseCase = VerifyPaymentUseCase(repository);
      subscribePaymentStatusUseCase = SubscribePaymentStatusUseCase(repository);
    });

    const testPlans = [
      SubscriptionPlanEntity(
        code: 'PLUS_MONTHLY',
        name: 'Gói 1 Tháng',
        price: 49000,
        durationDays: 30,
        description: 'Dành cho việc ôn thi cấp tốc',
      ),
      SubscriptionPlanEntity(
        code: 'PLUS_SEMESTER',
        name: 'Gói 1 Học kỳ',
        price: 149000,
        durationDays: 120,
        description: 'Trọn vẹn 1 kỳ học',
      ),
    ];

    const testPaymentResult = PaymentResultEntity(
      orderCode: 123456,
      amount: 149000,
      checkoutUrl: 'https://pay.payos.vn/web/123456',
      qrCode: '00020101021238...',
      plan: 'PLUS_SEMESTER',
    );

    const testPaymentStatus = PaymentStatusEntity(
      orderCode: 123456,
      amount: 149000,
      status: 'PAID',
      plan: 'PLUS_SEMESTER',
      isPaid: true,
    );

    test('GetAvailablePlansUseCase returns plans on success', () async {
      when(() => repository.getAvailablePlans())
          .thenAnswer((_) async => const Result.ok(testPlans));

      final result = await getAvailablePlansUseCase();

      expect(result.isOk, isTrue);
      expect(result.valueOrNull?.length, 2);
      expect(result.valueOrNull?.first.code, 'PLUS_MONTHLY');
      verify(() => repository.getAvailablePlans()).called(1);
    });

    test('GetAvailablePlansUseCase returns failure when repo fails', () async {
      when(() => repository.getAvailablePlans())
          .thenAnswer((_) async => const Result.err(ServerFailure(message: 'Network error')));

      final result = await getAvailablePlansUseCase();

      expect(result.isErr, isTrue);
      expect(result.failureOrNull?.message, 'Network error');
    });

    test('CreatePaymentUseCase returns payment details on success', () async {
      when(() => repository.createPayment('PLUS_SEMESTER'))
          .thenAnswer((_) async => const Result.ok(testPaymentResult));

      final result = await createPaymentUseCase('PLUS_SEMESTER');

      expect(result.isOk, isTrue);
      expect(result.valueOrNull?.orderCode, 123456);
      expect(result.valueOrNull?.amount, 149000);
      expect(result.valueOrNull?.plan, 'PLUS_SEMESTER');
      verify(() => repository.createPayment('PLUS_SEMESTER')).called(1);
    });

    test('VerifyPaymentUseCase returns payment status on success', () async {
      when(() => repository.verifyPayment(123456))
          .thenAnswer((_) async => const Result.ok(testPaymentStatus));

      final result = await verifyPaymentUseCase(123456);

      expect(result.isOk, isTrue);
      expect(result.valueOrNull?.isPaid, isTrue);
      expect(result.valueOrNull?.status, 'PAID');
      verify(() => repository.verifyPayment(123456)).called(1);
    });

    test('SubscribePaymentStatusUseCase emits payment status from stream', () async {
      when(() => repository.subscribePaymentStatus(123456))
          .thenAnswer((_) => Stream.value(const Result.ok(testPaymentStatus)));

      final stream = subscribePaymentStatusUseCase(123456);

      await expectLater(
        stream,
        emits(const Result.ok(testPaymentStatus)),
      );
      verify(() => repository.subscribePaymentStatus(123456)).called(1);
    });
  });

  group('PaymentRepositoryImpl', () {
    late MockPaymentRemoteDataSource remoteDataSource;
    late PaymentRepositoryImpl repository;

    setUp(() {
      remoteDataSource = MockPaymentRemoteDataSource();
      repository = PaymentRepositoryImpl(remoteDataSource: remoteDataSource);
    });

    test('maps SubscriptionPlanModel DTO to Entity', () async {
      const dtoList = [
        SubscriptionPlanModel(
          code: 'PLUS_MONTHLY',
          name: 'Gói 1 Tháng',
          price: 49000,
          description: 'Học 1 tháng',
        ),
      ];

      when(() => remoteDataSource.getAvailablePlans())
          .thenAnswer((_) async => dtoList);

      final result = await repository.getAvailablePlans();

      expect(result.isOk, isTrue);
      final entity = result.valueOrNull?.first;
      expect(entity?.code, 'PLUS_MONTHLY');
      expect(entity?.price, 49000);
    });

    test('maps CreatePaymentModel DTO to Entity', () async {
      const dto = CreatePaymentModel(
        orderCode: 998877,
        amount: 49000,
        checkoutUrl: 'https://pay.payos.vn/web/998877',
        qrCode: 'qr-sample',
        plan: 'PLUS_MONTHLY',
      );

      when(() => remoteDataSource.createPayment('PLUS_MONTHLY'))
          .thenAnswer((_) async => dto);

      final result = await repository.createPayment('PLUS_MONTHLY');

      expect(result.isOk, isTrue);
      expect(result.valueOrNull?.orderCode, 998877);
      expect(result.valueOrNull?.checkoutUrl, 'https://pay.payos.vn/web/998877');
    });

    test('maps PaymentStatusModel DTO to Entity', () async {
      const dto = PaymentStatusModel(
        orderCode: 998877,
        amount: 49000,
        status: 'PAID',
        plan: 'PLUS_MONTHLY',
      );

      when(() => remoteDataSource.verifyPayment(998877))
          .thenAnswer((_) async => dto);

      final result = await repository.verifyPayment(998877);

      expect(result.isOk, isTrue);
      expect(result.valueOrNull?.isPaid, isTrue);
      expect(result.valueOrNull?.status, 'PAID');
    });

    test('catches ServerException and returns ServerFailure', () async {
      when(() => remoteDataSource.createPayment(any()))
          .thenThrow(const ServerException(message: 'Lỗi máy chủ thanh toán'));

      final result = await repository.createPayment('PLUS_MONTHLY');

      expect(result.isErr, isTrue);
      expect(result.failureOrNull, isA<ServerFailure>());
      expect(result.failureOrNull?.message, 'Lỗi máy chủ thanh toán');
    });

    test('subscribePaymentStatus maps DTO stream to Entity stream', () async {
      const dto = PaymentStatusModel(
        orderCode: 998877,
        amount: 49000,
        status: 'PAID',
        plan: 'PLUS_MONTHLY',
      );

      when(() => remoteDataSource.subscribePaymentStatus(998877))
          .thenAnswer((_) => Stream.value(dto));

      final stream = repository.subscribePaymentStatus(998877);

      await expectLater(
        stream,
        emits(isA<Result<PaymentStatusEntity>>().having(
          (r) => r.valueOrNull?.isPaid,
          'isPaid',
          isTrue,
        )),
      );
      verify(() => remoteDataSource.subscribePaymentStatus(998877)).called(1);
    });
  });
}
