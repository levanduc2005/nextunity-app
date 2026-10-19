import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/core/config/app_config.dart';
import 'package:rental_car/core/providers/core_providers.dart';
import 'package:rental_car/core/storage/key_value_store.dart';
import 'package:rental_car/core/utils/app_logger.dart';

/// Boots the app inside a guarded zone with global error handling and the
/// async dependencies (storage) resolved and injected as provider overrides.
///
/// [builder] returns the root widget (kept as a parameter so tests and
/// different entry points/flavors can reuse this bootstrap).
Future<void> bootstrap(Widget Function() builder) async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Route framework errors through our logger.
      FlutterError.onError = (details) {
        AppLogger.instance.e(
          'FlutterError',
          error: details.exception,
          stackTrace: details.stack,
        );
        FlutterError.presentError(details);
      };

      // Catch errors from the platform side (engine).
      PlatformDispatcher.instance.onError = (error, stack) {
        AppLogger.instance.e(
          'PlatformDispatcher',
          error: error,
          stackTrace: stack,
        );
        return true;
      };

      AppLogger.instance.i('API Base URL configured: ${AppConfig.apiBaseUrl}');

      // Resolve async dependencies before the first frame.
      final keyValueStore = await SharedPreferencesStore.create();

      runApp(
        ProviderScope(
          overrides: [keyValueStoreProvider.overrideWithValue(keyValueStore)],
          observers: [if (kDebugMode) _LoggingProviderObserver()],
          child: builder(),
        ),
      );

      // Kích hoạt Silent Warm-up Ping ngầm để đánh thức Backend Render
      _warmUpBackend();
    },
    (error, stack) {
      AppLogger.instance.e(
        'Uncaught zone error',
        error: error,
        stackTrace: stack,
      );
    },
  );
}

/// Bắn 1 request ngầm nhẹ tới endpoint /public/health để đánh thức server Render nếu đang ngủ đông.
void _warmUpBackend() {
  unawaited(
    Dio(
          BaseOptions(
            connectTimeout: const Duration(seconds: 45),
            receiveTimeout: const Duration(seconds: 45),
          ),
        )
        .get<dynamic>('${AppConfig.apiBaseUrl}/public/health')
        .then((_) => AppLogger.instance.i('Backend warm-up: Online'))
        .catchError((_) {
          AppLogger.instance.w('Backend warm-up: Server waking up or offline');
        }),
  );
}

/// Logs provider lifecycle events in debug builds — handy while developing.
final class _LoggingProviderObserver extends ProviderObserver {
  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    AppLogger.instance.d(
      '[Provider +] ${context.provider.name ?? context.provider.runtimeType}',
    );
  }

  @override
  void didDisposeProvider(ProviderObserverContext context) {
    AppLogger.instance.d(
      '[Provider -] ${context.provider.name ?? context.provider.runtimeType}',
    );
  }
}
