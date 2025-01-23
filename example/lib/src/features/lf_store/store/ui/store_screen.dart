import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class StoreScreen extends ScreenStatefulWidget {
  final String title;

  const StoreScreen({
    super.key,
    required this.title,
  });

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends ScreenState<StoreScreen> {
  @override
  Color? get backgroundColor => Colors.white;

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
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: LFButton(
                text: 'Test ErrorValue',
                onTap: () {
                  try {
                    const errorValue = ErrorValue(
                      statusCode: kDefaultStatusCode,
                      errorCode: 'E001',
                      errorMessage: 'Error Message',
                    );
                    throw ErrorValueException(errorValue);
                  } catch (e) {
                    debugPrint('catch (original): ${e.toString()}');
                    if (e is ErrorValueException) {
                      final errorValue = e.value;
                      debugPrint('catch (errorValue): $errorValue');
                    }
                  } finally {
                    debugPrint('Finally');
                  }
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}
