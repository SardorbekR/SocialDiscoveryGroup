import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:social_discovery_group/features/states_selector/presentation/bloc/states_selector_bloc.dart';
import 'package:social_discovery_group/features/states_selector/presentation/widgets/error_page.dart';

class MockStatesSelectorBloc extends MockBloc<StatesSelectorEvent, StatesSelectorState>
    implements StatesSelectorBloc {}

void main() {
  testGoldens('ErrorPage renders correctly', (tester) async {
    await loadAppFonts();
    final mockBloc = MockStatesSelectorBloc();

    await tester.pumpWidgetBuilder(
      MaterialApp(
        home: Scaffold(body: ErrorPage(statesSelectorBloc: mockBloc)),
      ),
      surfaceSize: Device.iphone11.size,
    );

    await screenMatchesGolden(tester, 'error_page');
  });
}
