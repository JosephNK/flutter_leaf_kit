import 'package:example/src/network/services/api_service.dart';
import 'package:example/src/network/services/responses/api_error_response.dart';
import 'package:example/src/network/services/responses/serializer/serializers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class NetworkScreen extends ScreenStatefulWidget {
  final String title;

  const NetworkScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<NetworkScreen> createState() => _NetworkScreenState();
}

class _NetworkScreenState extends ScreenState<NetworkScreen> {
  @override
  Color? get backgroundColor => Colors.white;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Init
      HTTPChopper.shared.init(
        baseUrl: 'https://dummyjson.com/',
        services: [
          APIService.create(),
        ],
        converter: BuiltValueConverter(
          serializers: serializers,
        ),
        errorConverter: HttpExceptionErrorConverter(
          serializers: serializers,
        ),
      );
    });
  }

  @override
  Widget? buildScreen(BuildContext context) {
    return buildScaffold(context, null);
  }

  @override
  PreferredSizeWidget? buildAppbar(BuildContext context, Object? state) {
    return LFAppBar(
      title: LFAppBarTitle(text: widget.title),
    );
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              minimumSize: const Size(150, 80),
            ),
            onPressed: () {
              _action1();
            },
            child: const Text('Success'),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              minimumSize: const Size(150, 80),
            ),
            onPressed: () {
              _action2();
            },
            child: const Text('Error'),
          ),
        ],
      ),
    );
  }

  void _action1() async {
    try {
      final Map<String, dynamic> query = {'limit': 5};
      final apiService =
          HTTPChopper.shared.chopperClient.getService<APIService>();
      final response = await apiService.getProducts(query);
      if (response.isSuccessful) {
        final body = response.body;
        final products = body?.products;
        Logging.d('Response Success: Products: $products');
      } else {
        final code = response.statusCode;
        final error = response.error as APIErrorResponse;
        Logging.e(
            'Response Error: $code, $error, errorMessage: ${error.errorMessage}');
      }
    } on Exception catch (e) {
      if (e is NotFoundException) {
        Logging.e('NotFoundException: $e');
      } else {
        Logging.e('Exception: $e');
      }
    }
  }

  void _action2() async {
    try {
      final Map<String, dynamic> query = {'limit': 5};
      final apiService =
          HTTPChopper.shared.chopperClient.getService<APIService>();
      final response = await apiService.getNotFound(query);
      if (response.isSuccessful) {
        final body = response.body;
        final products = body?.products;
        Logging.d('Response Success: Products: $products');
      } else {
        final code = response.statusCode;
        final error = response.error as APIErrorResponse;
        Logging.e(
            'Response Error: $code, $error, errorMessage: ${error.errorMessage}');
      }
    } on Exception catch (e) {
      if (e is NotFoundException) {
        Logging.e('NotFoundException: $e');
      } else {
        Logging.e('Exception: $e');
      }
    }
  }
}
