part of http_chopper;

class BuiltValueConverter extends JsonConverter {
  final Serializers serializers;

  static Serializers? jsonSerializers;

  BuiltValueConverter({
    required this.serializers,
  }) {
    BuiltValueConverter.jsonSerializers = (serializers.toBuilder()
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

  BuiltList<T> _deserializeListOf<T>(Iterable value) => BuiltList(
        value.map((value) => _deserialize<T>(value)).toList(growable: false),
      );

  dynamic _decode<T>(dynamic entity) {
    /// handle case when we want to access to Map<String, dynamic> directly
    /// getResource or getMapResource
    /// Avoid dynamic or unconverted value, this could lead to several issues
    if (entity is T) {
      return entity;
    }

    try {
      if (entity is List) {
        return _deserializeListOf<T>(entity);
      }
      return _deserialize<T>(entity);
    } catch (e) {
      Logging.e(e);
      return null;
    }
  }

  @override
  FutureOr<Response<ResultType>> convertResponse<ResultType, ItemType>(
    Response response,
  ) async {
    // use [JsonConverter] to decode json
    final Response jsonResponse = await super.convertResponse(response);
    final body = _decode<ItemType>(jsonResponse.body);

    return jsonResponse.copyWith<ResultType>(body: body);
  }

  @override
  Request convertRequest(Request request) => super.convertRequest(
        request.copyWith(
          body: jsonSerializers?.serialize(request.body),
        ),
      );
}
