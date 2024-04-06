import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:social_discovery_group/features/states_selector/data/data_sources/states_selector_datasources.dart';
import 'package:social_discovery_group/features/states_selector/data/models/address_model.dart';
import 'package:social_discovery_group/features/states_selector/domain/repositories/states_selector_repository.dart';

import 'states_selector_repository_test.mocks.dart';

@GenerateMocks([StatesSelectorDatasource])
void main() {
  late StatesSelectorRepository repository;
  late MockStatesSelectorDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockStatesSelectorDatasource();
    repository = StatesSelectorRepository(dataSource: mockDatasource);
  });

  group('getCountries', () {
    test('returns a list of Address when the datasource returns a list of Address', () async {
      when(mockDatasource.getCountries()).thenAnswer((_) async => [Address(id: 1, value: 'USA')]);

      expect(await repository.getCountries(), isA<List<Address>>());
    });

    test('throws an exception when the datasource throws an exception', () {
      when(mockDatasource.getCountries()).thenThrow(Exception());

      expect(repository.getCountries(), throwsA(isA<Exception>()));
    });
  });

  group('getStates', () {
    test('returns a list of Address when the datasource returns a list of Address', () async {
      when(mockDatasource.getStates(any))
          .thenAnswer((_) async => [Address(id: 2, value: 'California')]);

      expect(await repository.getStates('1'), isA<List<Address>>());
    });

    test('throws an exception when the datasource throws an exception', () {
      when(mockDatasource.getStates(any)).thenThrow(Exception());

      expect(repository.getStates('1'), throwsA(isA<Exception>()));
    });
  });
}
