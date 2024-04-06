import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:social_discovery_group/core/environment/environment_configs.dart';
import 'package:social_discovery_group/core/shared/app_print.dart';
import 'package:social_discovery_group/core/shared/constants.dart';
import 'package:social_discovery_group/injection_container/injection_container.config.dart';

final _injector = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() => _injector.init();

Future<void> init() async {
  configureDependencies();
  _initInterceptors();

  enableErrorReporting();

  await _injector.allReady();
}

void enableErrorReporting() {
  if (EnvironmentConfigs.environment != Constants.prod) {
    FlutterError.onError = (details) async {
      await Sentry.captureException(details.exception, stackTrace: details.stack);
      appPrint(details);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      Sentry.captureException(error, stackTrace: stack);
      appPrint(error);
      return true;
    };
  }
}

void _initInterceptors() {
  _injector<Dio>().interceptors.addAll(
    [
      RetryInterceptor(
        dio: _injector(),
        logPrint: appPrint,
        retryEvaluator: _retryOnlyGetRequestsEvaluator,
      ),

      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers[Constants.xApiKey] = Constants.xApiKeyValue;
          options.headers[Constants.userAgent] = Constants.userAgentValue;
          return handler.next(options);
        },
      ),

      ///here might be other interceptors as well, such as refreshTokenInterceptor, loggingInterceptor in debug mode, etc.
    ],
  );
}

FutureOr<bool> _retryOnlyGetRequestsEvaluator(DioException error, int attempt) {
  if (error.requestOptions.method != Constants.GET) {
    return false;
  }

  return DefaultRetryEvaluator(defaultRetryableStatuses).evaluate(error, attempt);
}
