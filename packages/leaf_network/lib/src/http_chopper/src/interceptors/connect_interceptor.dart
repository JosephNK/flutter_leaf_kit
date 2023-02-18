part of http_chopper;

class ConnectInterceptor implements RequestInterceptor {
  @override
  Future<Request> onRequest(Request request) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      final exception = InternetNotConnectException(
        0,
        'Internet Not Connect Error',
        'There is no internet connection.',
      );
      throw exception;
    }
    return request;
  }
}
