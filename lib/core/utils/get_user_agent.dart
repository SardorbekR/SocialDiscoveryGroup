import 'package:package_info_plus/package_info_plus.dart';

String getUserAgent(PackageInfo packageInfo) {
  final String appName = packageInfo.appName;
  final String version = packageInfo.version;
  final String buildNumber = packageInfo.buildNumber;
  return '$appName/$version ($buildNumber)';
}
