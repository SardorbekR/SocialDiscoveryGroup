import 'package:dio/dio.dart';
import 'package:social_discovery_group/core/shared/app_print.dart';
import 'package:social_discovery_group/core/shared/constants.dart';

typedef OnSuccess<T> = Future<void> Function(T result);
typedef OnError<T> = void Function(T error);
typedef OnDioException = void Function(DioException dioException);

const _dataNotFound = 'Data not found';
const _cannotAccessResource = 'Cannot access the resource';
const _unknownError = 'Unknown error occur';

extension FutureExt<T> on Future<T> {
  Future<void> errorHandler({
    required OnSuccess<T> onSuccess,
    OnError<String>? onError,
    OnDioException? onDioException,
  }) async {
    try {
      await onSuccess.call(await this);
    } on DioException catch (error, stackTrace) {
      appPrint(stackTrace);
      appPrint(error);

      var errorMsg = '';

      final response = error.response;
      if (response != null) {
        if (response.statusCode == Constants.statusCode404) {
          errorMsg = _dataNotFound;
        } else if (response.statusCode == Constants.statusCode403) {
          errorMsg = _cannotAccessResource;
        }
      }

      onError?.call(errorMsg);
      onDioException?.call(error);
    } catch (error, stackTrace) {
      appPrint(stackTrace);
      appPrint(error);

      onError?.call(_unknownError);
    }
  }
}
