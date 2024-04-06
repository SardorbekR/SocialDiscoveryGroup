import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:social_discovery_group/features/states_selector/data/data_sources/states_selector_datasources.dart';
import 'package:social_discovery_group/features/states_selector/data/models/address_model.dart';

import 'states_selector_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Dio>()])
void main() {
  late StatesSelectorDatasource datasource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    datasource = StatesSelectorDatasource(dio: mockDio);
  });

  group('getCountries', () {
    test('returns a list of Address when the response code is 200', () async {
      when(mockDio.get('/countries')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/countries'),
          data: jsonDecode('[{"id": 1, "value": "USA"}]'),
          statusCode: 200,
        ),
      );

      expect(await datasource.getCountries(), isA<List<Address>>());
    });

    test('throws a DioException when the response code is not 200', () {
      when(mockDio.get('/countries')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/countries'),
          data: 'Not Found',
          statusCode: 404,
        ),
      );

      expect(datasource.getCountries(), throwsA(isA<DioException>()));
    });
  });

  group('getStates', () {
    test('returns a list of Address when the response code is 200', () async {
      when(mockDio.get('/countries/1/states')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/states/1'),
          data: jsonDecode('[{"id": 2, "value": "California"}]'),
          statusCode: 200,
        ),
      );

      expect(await datasource.getStates('1'), isA<List<Address>>());
    });

    test('throws a DioException when the response code is not 200', () {
      when(mockDio.get('/countries/1/states')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/states/1'),
          data: 'Not Found',
          statusCode: 404,
        ),
      );

      expect(datasource.getStates('1'), throwsA(isA<DioException>()));
    });
  });
}
