import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:social_discovery_group/core/environment/environment_configs.dart';

@module
abstract class RegisterModule {
  @singleton
  //linter assuming that Flavors.baseUrl is empty but it's not
  //ignore: avoid_redundant_argument_values
  Dio dio() => Dio(BaseOptions(baseUrl: EnvironmentConfigs.baseUrl));
}
