part of http_chopper;

class HttpExceptionErrorConverter extends ErrorConverter {
  final Serializers serializers;

  static Serializers? jsonSerializers;
  static const JsonConverter jsonConverter = JsonConverter();

  HttpExceptionErrorConverter({
    required this.serializers,
  }) {
    HttpExceptionErrorConverter.jsonSerializers = (serializers.toBuilder()
          ..addPlugin(
            StandardJsonPlugin(),
          ))
        .build();
  }

  T? _deserialize<T>(dynamic value) {
    final serializer = jsonSerializers?.serializerForType(T) as Serializer<T>?;
    if (serializer == null) {
      throw Exception('No serializer for type $T');
    }
    return jsonSerializers?.deserializeWith<T>(
      serializer,
      value,
    );
  }

  @override
  FutureOr<Response<ResultType>> convertError<ResultType, ItemType>(
    Response response,
  ) async {
    // use [JsonConverter] to decode json
    final Response jsonResponse = await jsonConverter.convertResponse(response);

    final base = jsonResponse.base;
    final statusCode = base.statusCode;
    final body = jsonResponse.body;

    debugPrint(
        '[http_chopper][convertError] statusCode: $statusCode, body: $body');

    //final body = {'error_message': 'Test ErrorMessage', 'total': 100};

    dynamic object;

    try {
      object ??= _deserialize<ResultType>(body);
    } catch (_) {
      object ??= body;
    }

    String message = (object is String) ? object : '';

    HTTPException? exception;
    switch (statusCode) {
      case 400:
        exception = BadRequestException(
          statusCode,
          message,
          body,
        );
        break;
      case 401:
        exception = UnauthorisedException(
          statusCode,
          message,
          body,
        );
        break;
      case 404:
        exception = NotFoundException(
          statusCode,
          message,
          body,
        );
        break;
      case 408:
        exception = TimeoutRequestException(
          statusCode,
          message,
          body,
        );
        break;
      case 500:
        exception = InternalServerException(
          statusCode,
          message,
          body,
        );
        break;
      case 503:
        exception = ServiceUnavailableException(
          statusCode,
          message,
          body,
        );
        break;
      default:
        if (object is ResultType) {
          debugPrint(
              '[http_chopper][convertError] object is ResultType :: $object');
          return response.copyWith<ResultType>(
            body: object,
            bodyError: object,
          );
        }
        exception = HTTPException(
          statusCode,
          message,
          body,
        );
        break;
    }

    throw exception;
  }
}
