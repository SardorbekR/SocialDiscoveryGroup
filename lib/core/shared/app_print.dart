import 'package:flutter/foundation.dart';
import 'package:social_discovery_group/core/environment/environment_configs.dart';
import 'package:social_discovery_group/core/shared/constants.dart';

void appPrint(Object? msg) {
  if (msg != null && EnvironmentConfigs.environment == Constants.development) {
    debugPrint(msg.toString());
  }
}
