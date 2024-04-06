import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:social_discovery_group/features/states_selector/data/models/address_model.dart';
import 'package:social_discovery_group/features/states_selector/presentation/bloc/states_selector_bloc.dart';
import 'package:social_discovery_group/features/states_selector/presentation/pages/states_selector_page.dart';

import '../bloc/states_selector_bloc_test.mocks.dart';
import 'error_page_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockStatesSelectorBloc mockStatesSelectorBloc;
  late MockStatesSelectorRepository mockStatesSelectorRepository;

  setUp(() async {
    await loadAppFonts();

    mockStatesSelectorBloc = MockStatesSelectorBloc();
    mockStatesSelectorRepository = MockStatesSelectorRepository();

    GetIt.instance.registerFactory<StatesSelectorBloc>(() => mockStatesSelectorBloc);
    await loadAppFonts();

    // Bloc State Stub
    whenListen(
      mockStatesSelectorBloc,
      Stream<StatesSelectorState>.value(
        CountriesFetched(countries: [Address(id: 1, value: 'USA')]),
      ),
      initialState: const FetchingCountries(),
    );

    // Repositories stub
    when(
      mockStatesSelectorRepository.getCountries(),
    ).thenAnswer(
      (_) async => Future<List<Address>>.value([Address(id: 1, value: 'USA')]),
    );
  });

  testGoldens('StatesSelectorPage renders correctly', (tester) async {
    await loadAppFonts();

    await tester.pumpWidgetBuilder(
      Provider.value(
        value: GetIt.instance,
        child: Builder(
          builder: (context) {
            return const MaterialApp(
              home: StatesSelectorPage(),
            );
          },
        ),
      ),
      surfaceSize: Device.iphone11.size,
    );

    await screenMatchesGolden(tester, 'states_selector_page');
  });
}
