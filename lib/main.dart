import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:social_discovery_group/core/environment/environment_configs.dart';
import 'package:social_discovery_group/core/shared/app_print.dart';
import 'package:social_discovery_group/features/states_selector/presentation/pages/states_selector_page.dart';
import 'package:social_discovery_group/injection_container/injection_container.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      await init();

      await SentryFlutter.init(
        (options) {
          options
            ..dsn = EnvironmentConfigs.sentryDSN
            ..environment = EnvironmentConfigs.environment
            // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
            // We recommend adjusting this value in production.
            ..tracesSampleRate = 1.0;
        },
        appRunner: () => runApp(
          Provider.value(
            value: GetIt.instance,
            child: const MaterialApp(
              home: StatesSelectorPage(),
            ),
          ),
        ),
      );
    },
    (exception, stackTrace) async {
      appPrint(stackTrace);
      await Sentry.captureException(exception, stackTrace: stackTrace);
    },
  );
}
