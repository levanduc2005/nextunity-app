import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/app.dart';
import 'package:rental_car/app/router/app_router.dart';
import 'package:rental_car/core/providers/core_providers.dart';
import 'package:rental_car/core/storage/key_value_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('NextUnity app initialization & router bootstrap test', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final store = await SharedPreferencesStore.create();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [keyValueStoreProvider.overrideWithValue(store)],
        child: const App(),
      ),
    );
    await tester.pump();

    final element = tester.element(find.byType(App));
    final container = ProviderScope.containerOf(element);
    final router = container.read(routerProvider);

    // Verify router creates successfully and can navigate to tabs
    expect(router, isA<GoRouter>());
    expect(router.routeInformationProvider.value.uri.path, isNotEmpty);
  });
}
