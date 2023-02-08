part of http_chopper;

class ThrowExceptionInterceptor implements ResponseInterceptor {
  @override
  Response onResponse(Response response) {
    final isError = (response.error is Exception || response.error is Error);
    return isError ? throw response.error! : response;
  }
}
