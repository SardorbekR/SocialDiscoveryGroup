class EnvironmentConfigs {
  static const String environment =
      String.fromEnvironment('environment', defaultValue: 'development');
  static const String baseUrl =
      String.fromEnvironment('baseUrl', defaultValue: 'https://api.stagingcupid.com/api/v1/');
  static const String sentryDSN = String.fromEnvironment('sentryDSN');
}
