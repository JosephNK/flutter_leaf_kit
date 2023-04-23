part of http_chopper;

class LogResponseInterceptor implements ResponseInterceptor {
  @override
  Response onResponse(Response response) {
    final base = response.base.request;
    String message = '';
    message +=
        '\n${base?.method} ${base?.url.toString()} ${response.statusCode}';
    response.base.headers.forEach((k, v) => message += '\n$k: $v');

    if (response.isSuccessful) {
      Logging.i('[Success] Response\n$message\n\n${response.body}');
    } else {
      final error = response.error;
      Logging.e('[Error] Response:\n$error');
    }
    return response;
  }
}
