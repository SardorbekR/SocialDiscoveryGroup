import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:social_discovery_group/features/states_selector/data/models/address_model.dart';
import 'package:social_discovery_group/features/states_selector/domain/repositories/states_selector_repository.dart';
import 'package:social_discovery_group/features/states_selector/presentation/bloc/states_selector_bloc.dart';

import 'states_selector_bloc_test.mocks.dart';

@GenerateMocks([StatesSelectorRepository])
void main() {
  late StatesSelectorBloc bloc;
  late MockStatesSelectorRepository mockRepository;

  setUp(() {
    mockRepository = MockStatesSelectorRepository();
    bloc = StatesSelectorBloc(repository: mockRepository);
  });

  tearDown(() {
    bloc.close();
  });

  group('StatesSelectorBloc', () {
    final countries = [Address(id: 1, value: 'USA')];
    final states = [Address(id: 2, value: 'California')];

    blocTest<StatesSelectorBloc, StatesSelectorState>(
      'emits [FetchingCountries, CountriesFetched] when GetCountries is added',
      build: () {
        when(mockRepository.getCountries()).thenAnswer((_) async => countries);
        return bloc;
      },
      act: (bloc) => bloc.add(const GetCountries()),
      expect: () => <StatesSelectorState>[
        const FetchingCountries(),
        CountriesFetched(countries: countries),
      ],
    );

    blocTest<StatesSelectorBloc, StatesSelectorState>(
      'emits [FetchingStates, StatesFetched] when GetStates is added',
      build: () {
        when(mockRepository.getStates(any)).thenAnswer((_) async => states);
        return bloc;
      },
      act: (bloc) => bloc.add(const GetStates(countryId: 1)),
      expect: () => <StatesSelectorState>[
        const FetchingStates(),
        StatesFetched(states: states),
      ],
    );

    blocTest<StatesSelectorBloc, StatesSelectorState>(
      'emits [FetchingCountries, StatesSelectorError] when GetCountries is added and repository throws',
      build: () {
        when(mockRepository.getCountries()).thenAnswer(
          (_) async => throw Exception('Error'),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const GetCountries()),
      expect: () => <StatesSelectorState>[
        const FetchingCountries(),
        const StatesSelectorError(message: 'Unknown error occur'),
      ],
    );

    blocTest<StatesSelectorBloc, StatesSelectorState>(
      'emits [FetchingStates, StatesSelectorError] when GetStates is added and repository throws',
      build: () {
        when(mockRepository.getStates(any)).thenAnswer(
          (_) async => throw Exception('Error'),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const GetStates(countryId: 1)),
      expect: () => <StatesSelectorState>[
        const FetchingStates(),
        const StatesSelectorError(message: 'Unknown error occur'),
      ],
    );
  });
}
