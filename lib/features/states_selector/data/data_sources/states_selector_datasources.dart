import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:social_discovery_group/core/shared/constants.dart';
import 'package:social_discovery_group/features/states_selector/data/models/address_model.dart';

@injectable
class StatesSelectorDatasource {
  final Dio _dio;

  const StatesSelectorDatasource({required Dio dio}) : _dio = dio;

  Future<List<Address>> getCountries() async {
    final response = await _dio.get('/countries');

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Address.addressesFromJson(jsonEncode(response.data));
    }

    throw DioException(requestOptions: response.requestOptions, response: response);
  }

  Future<List<Address>> getStates(String id) async {
    final response = await _dio.get('/countries/$id/states');

    if (response.statusCode == Constants.statusCode200 ||
        response.statusCode == Constants.statusCode201) {
      return Address.addressesFromJson(jsonEncode(response.data));
    }

    throw DioException(requestOptions: response.requestOptions, response: response);
  }
}
